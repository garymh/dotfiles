const { isDocked } = require("../utils.js");

const config = {
  mqtt_host: "homeassistant.local",
  mqtt_user: "gary",
  mqtt_port: "1883",
  debug: false,
};

const passPromise = hs.task.shell(
  "security find-generic-password -a hammerspoon -s homeassistant -w",
);

async function mqttPublish(topic, message) {
  const pass = (await passPromise).stdout.trim();
  if (!pass) {
    console.warn("[mqtt] no password from keychain");
    return;
  }

  const cmd =
    "/opt/homebrew/bin/mosquitto_pub -r -h " +
    config.mqtt_host +
    " -u " +
    config.mqtt_user +
    ' -P "' +
    pass +
    '"' +
    " -p " +
    config.mqtt_port +
    " -t " +
    topic +
    ' -m "' +
    message +
    '"';
  if (config.debug) console.log("Command: " + cmd);

  const res = await hs.task.shell(cmd);
  if (config.debug)
    console.log(
      "rc=" + res.exitCode + " stdout=" + res.stdout + " stderr=" + res.stderr,
    );
}

// Resolve what to mirror for `app`, or null when there is nothing to publish.
function minimonValue(app, override) {
  if (override != null) return override;

  const win = app.focusedWindow;
  if (!win) return null;

  const parts = win.title.split(" ");
  if (app.title === "Ghostty") {
    if (parts[0] === "vim") return "vim";
    if (parts[0] === "irb" || (parts[0] === "rails" && parts[1] === "c")) {
      return "IRB";
    }
    return "Terminal";
  }
  if (
    app.title === "Neovide" ||
    app.title === "VimR" ||
    app.title === "Nvmm"
  ) {
    return "vim";
  }
  return app.title;
}

// `force` republishes an unchanged value (app switches). Title changes don't: a spinner can retitle
// a window several times a second.
async function dostuff(app, override, force) {
  const value = minimonValue(app, override);
  if (value == null) return;
  if (!force && value === lastPublished) return;
  lastPublished = value;
  await mqttPublish("minimon", value);
}

// AXTitleChanged is the only way to see a title change while the app stays frontmost (Ghostty tab
// switch, vim renaming itself). Watching the application element also delivers descendant title
// changes (Ghostty's tab buttons), hence the AXWindow filter. Handler and debounce timer live on
// globalThis so pre-0.0.14 HS2 doesn't GC them (upstream-issues.md HS2-1).
const TITLE_DEBOUNCE = 0.3;

// Only apps whose window title carries the payload need a title watcher; for the rest,
// didActivate is enough.
const TITLE_WATCH_APPS = ["Ghostty"];

const watchedApps = new Map();
let lastPublished = null;

globalThis.titleDebounce = null;

globalThis.mqttTitleChanged = function (notification, element) {
  if (element.role !== "AXWindow") return;

  const app = hs.application.fromPID(element.pid);
  if (!app || !app.isActive || !isDocked()) return;

  if (globalThis.titleDebounce) globalThis.titleDebounce.stop();
  globalThis.titleDebounce = hs.timer.doAfter(TITLE_DEBOUNCE, () => {
    globalThis.titleDebounce = null;
    dostuff(app).catch((e) => console.log("[mqtt] title change: " + e));
  });
};

function watchAppTitles(app) {
  const name = app && app.title;
  if (!name || !TITLE_WATCH_APPS.includes(name) || watchedApps.has(name)) return;

  const element = app.axElement();
  if (!element) return;

  hs.ax.on(
    element,
    hs.ax.notificationTypes.titleChanged,
    globalThis.mqttTitleChanged,
  );
  watchedApps.set(name, app);
}

function unwatchAppTitles(app) {
  const name = app && app.title;
  if (!name || !watchedApps.delete(name)) return;
  hs.ax.off(
    app.axElement(),
    hs.ax.notificationTypes.titleChanged,
    globalThis.mqttTitleChanged,
  );
}

const MAIL_JUNK_SCRIPT = `
  use AppleScript version "2.4"
  use scripting additions
  use framework "Foundation"
  use framework "ScriptingBridge"

  tell application "Mail"
  tell mailbox "Junk" of account "iCloud"
  set read status of messages whose read status is false to true
  end tell
  end tell
`;

function onAppDidLaunch(app) {
  if (!app) return;
  watchAppTitles(app);
}

function onAppDidTerminate(app) {
  if (!app) return;
  unwatchAppTitles(app);
}

async function onAppDidActivate(app) {
  try {
    if (!app) return;
    const name = app.title;

    if (name === "Mail") {
      hs.osascript
        .applescript(MAIL_JUNK_SCRIPT)
        .then((r) => {
          if (!r.success) console.log("[mqtt] mail script failed: " + r.raw);
        })
        .catch((e) => console.log("[mqtt] mail script error: " + e));
    }

    if (!isDocked()) return;

    if (name === "Firefox Developer Edition") {
      await dostuff(app, "Work", true);
    } else {
      await dostuff(app, null, true);
    }
  } catch (e) {
    console.log("[mqtt] " + e);
  }
}

hs.application.on("didLaunch", onAppDidLaunch);
hs.application.on("didTerminate", onAppDidTerminate);
hs.application.on("didActivate", onAppDidActivate);

// Apps already running when the config loads never fire didLaunch.
hs.application.runningApplications().forEach(watchAppTitles);

hs.permissions.requestAccessibility();
