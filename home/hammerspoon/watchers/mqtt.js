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

  if (app.name === "Ghostty") {
    // `title` is null when the AX title read fails (window without AXTitle, app busy).
    const parts = (win.title || "").split(" ");
    if (parts[0] === "vim") return "vim";
    if (parts[0] === "irb" || (parts[0] === "rails" && parts[1] === "c")) {
      return "IRB";
    }
    return "Terminal";
  }
  if (
    app.name === "Neovide" ||
    app.name === "VimR" ||
    app.name === "Nvmm"
  ) {
    return "vim";
  }
  return app.name;
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
// changes (Ghostty's tab buttons), hence the AXWindow filter.
const TITLE_DEBOUNCE = 0.3;

// Only apps whose window title carries the payload need a title watcher; for the rest,
// didActivate is enough.
const TITLE_WATCH_APPS = ["Ghostty"];

const watchedApps = new Map();
let lastPublished = null;

let titleDebounce = null;

function onTitleChanged(notification, element) {
  if (element.role !== "AXWindow") return;

  const app = hs.application.fromPID(element.pid);
  if (!app || !app.isActive || !isDocked()) return;

  if (titleDebounce) titleDebounce.stop();
  titleDebounce = hs.timer.doAfter(TITLE_DEBOUNCE, () => {
    titleDebounce = null;
    dostuff(app).catch((e) => console.log("[mqtt] title change: " + e));
  });
}

// Apps between willLaunch and didLaunch: they activate before their AX answers, so didActivate
// leaves the first attach to didLaunch (upstream-issues.md AX-3) and only retries after that.
const launchingApps = new Set();

function watchAppTitles(app) {
  const name = app && app.name;
  if (!name || !TITLE_WATCH_APPS.includes(name) || watchedApps.has(name)) return;

  const element = app.axElement();
  if (!element) return;

  try {
    hs.ax.on(element, hs.ax.notificationTypes.titleChanged, onTitleChanged);
    watchedApps.set(name, app);
  } catch (e) {
    console.error("[mqtt] hs.ax.on failed for " + name + ": " + e);
  }
}

// No hs.ax.off(): hs.ax drops the watchers of a quit app itself, and an off() from didTerminate
// runs before it does and fails against the dead process (upstream-issues.md AX-2).
function unwatchAppTitles(app) {
  const name = app && app.name;
  if (name) watchedApps.delete(name);
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

function onAppWillLaunch(app) {
  if (app && app.name) launchingApps.add(app.name);
}

function onAppDidLaunch(app) {
  if (!app) return;
  launchingApps.delete(app.name);
  watchAppTitles(app);
}

function onAppDidTerminate(app) {
  if (!app) return;
  launchingApps.delete(app.name);
  unwatchAppTitles(app);
}

async function onAppDidActivate(app) {
  try {
    if (!app) return;
    const name = app.name;
    if (!launchingApps.has(name)) watchAppTitles(app);

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

hs.application.on("willLaunch", onAppWillLaunch);
hs.application.on("didLaunch", onAppDidLaunch);
hs.application.on("didTerminate", onAppDidTerminate);
hs.application.on("didActivate", onAppDidActivate);

// Apps already running when the config loads never fire didLaunch.
hs.application.runningApplications().forEach(watchAppTitles);

hs.permissions.requestAccessibility();
