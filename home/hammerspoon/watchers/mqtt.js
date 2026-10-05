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

// `force` republishes an unchanged value, for app switches where the retained topic is the whole
// point. Title changes skip it: one window title can change several times a second (spinners), and
// re-publishing the same payload for each of those is pure noise on the broker.
async function dostuff(app, override, force) {
  const value = minimonValue(app, override);
  if (value == null) return;
  if (!force && value === lastPublished) return;
  lastPublished = value;
  await mqttPublish("minimon", value);
}

// ponytail: event-driven since 2026-09-29 — hooking AXTitleChanged is the only way to see a title
// change that happens while the app is already frontmost (switching a Ghostty tab, vim renaming
// itself, a browser tab change), and it needs no polling. Two bugs had to be fixed for this to be
// usable:
//   - AXSwift hashed the UIElement wrapper instead of the AXUIElement it wraps (CFHash(self) vs
//     CFHash(element)), which made equal elements hash unequally and, inside this app, recursed
//     through -[SwiftObject hash] into hashValue until the stack died.
//   - HSAXModule._removeWatcher's AXUIElement validity check was inverted, so notifications were
//     never actually removed from a live element's observer.
// Hammerspoon 2 0.0.13 upstreamed both fixes ("hs.ax watcher now actually works") and renamed the
// watcher API to hs.ax.on()/off().
// Registering on the *application* element is enough: AX delivers AXTitleChanged for the window and
// for descendant elements that carry a title (Ghostty's tab buttons), so filter on role.
//
// Callbacks and timers passed to native code die with JS reachability, and a module-scope binding is
// not enough (a timer handle here lost its callback ~2s after load: "hs.timer: callback is not a
// function"), so the handler and the debounce handle are pinned on globalThis, as urlevent handlers
// here are too.
const TITLE_DEBOUNCE = 0.3;

// Only apps whose *window title* carries the payload need an AX watcher; every other app's value
// is its own name (or a constant like "vim"), neither of which changes while the app stays
// frontmost, so didActivate below is enough for them. That makes this the same coverage the old
// 0.5s Ghostty-only poll had.
const TITLE_WATCH_APPS = ["Ghostty"];

const watchedApps = new Map();
let lastPublished = null;

globalThis.titleDebounce = null;

globalThis.mqttTitleChanged = function (notification, element) {
  // Application-element watchers also receive descendant title changes (e.g. Ghostty's tab
  // buttons), which say the same thing as the window's own title.
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

// ponytail: 0.0.13 replaced the single addWatcher(event, app) callback with one on() registration
// per event; the listener now receives only the app.
function onAppDidLaunch(app) {
  if (!app) return;
  watchAppTitles(app);
}

function onAppDidTerminate(app) {
  if (!app) return;
  unwatchAppTitles(app);
}

// ponytail: HS2 uses didActivate/didDeactivate, not activated/deactivated like HS1.
async function onAppDidActivate(app) {
  try {
    if (!app) return;
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

// ponytail: hs.window titles come from AX, so both the payload lookup and the title watchers need this.
hs.permissions.requestAccessibility();
