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

async function dostuff(app, override) {
  if (override != null) {
    await mqttPublish("minimon", override);
    return;
  }

  const win = app.focusedWindow;
  if (!win) return;

  const title = win.title;
  if (app.title === "Ghostty") {
    const parts = title.split(" ");
    if (parts[0] === "vim") {
      await mqttPublish("minimon", "vim");
    } else if (
      parts[0] === "irb" ||
      (parts[0] === "rails" && parts[1] === "c")
    ) {
      await mqttPublish("minimon", "IRB");
    } else {
      await mqttPublish("minimon", "Terminal");
    }
  } else if (
    app.title === "Neovide" ||
    app.title === "VimR" ||
    app.title === "Nvmm"
  ) {
    await mqttPublish("minimon", "vim");
  } else {
    await mqttPublish("minimon", app.title);
  }
}

// ponytail: hs.uielement.watcher is gone — hs.ax.addWatcher(app, notification, listener) replaces it.
// Register with the raw name ("AXTitleChanged") but the callback receives the camelCase key
// ("titleChanged"), because HSAXModule maps it back through notificationTypes before invoking us.
// Watchers are keyed "<pid>:<notification>" in Swift, so we track the process, not the app object,
// and re-register when Ghostty restarts. AX keeps delivering while backgrounded, so we gate on
// isActive instead of v1's applicationDeactivated-stops-the-watcher pattern.
const TITLE_CHANGED = hs.ax.notificationTypes.titleChanged;

let titleApp = null;
let titleHandler = null;
let titleDebounce = null;

function unwatchTitles() {
  if (titleApp && titleHandler)
    hs.ax.removeWatcher(titleApp, TITLE_CHANGED, titleHandler);
  if (titleDebounce) titleDebounce.stop();
  titleDebounce = null;
  titleApp = null;
  titleHandler = null;
}

function watchTitles(app) {
  if (titleApp && titleApp.pid === app.pid) return;
  unwatchTitles();

  titleApp = app;
  titleHandler = () => {
    if (!titleApp || !titleApp.isActive || !isDocked()) return;
    if (titleDebounce) titleDebounce.stop();
    titleDebounce = hs.timer.doAfter(0.3, () => {
      titleDebounce = null;
      dostuff(titleApp).catch((e) => console.log("[mqtt] title change: " + e));
    });
  };

  hs.ax.addWatcher(app, TITLE_CHANGED, titleHandler);
  console.log("[mqtt] watching Ghostty title changes (pid " + app.pid + ")");
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

hs.application.addWatcher(async (eventName, app) => {
  // ponytail: HS2 uses didActivate/didDeactivate, not activated/deactivated like HS1.
  try {
    if (!app) return;

    if (app.title === "Ghostty") {
      if (eventName === "didLaunch") watchTitles(app);
      else if (
        eventName === "didTerminate" &&
        titleApp &&
        titleApp.pid === app.pid
      )
        unwatchTitles();
    }

    if (eventName !== "didActivate") return;
    const name = app.title;

    if (name === "Mail") {
      // ponytail: HS2 osascript resolves with {success, result, raw} even on failure — .catch() alone misses it.
      hs.osascript
        .applescript(MAIL_JUNK_SCRIPT)
        .then((r) => {
          if (!r.success) console.log("[mqtt] mail script failed: " + r.raw);
        })
        .catch((e) => console.log("[mqtt] mail script error: " + e));
    }

    if (!isDocked()) return;

    if (name === "Firefox Developer Edition") {
      await dostuff(app, "Work");
    } else if (name === "Neovide" || name === "Ghostty") {
      await dostuff(app);
    } else {
      await dostuff(app);
    }
  } catch (e) {
    console.log("[mqtt] " + e);
  }
});

// ponytail: hs.ax.addWatcher() silently no-ops (logs an error) without Accessibility permission.
hs.permissions.requestAccessibility();

// HS2 emits no launch event for already-running apps, so attach on load too.
const runningGhostty = hs.application.matchingName("Ghostty");
if (runningGhostty) watchTitles(runningGhostty);
