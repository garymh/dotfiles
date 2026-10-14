// send-to-omnifocus.js — files the frontmost app's current item to OmniFocus via per-app AppleScript.
// Primary trigger: Karabiner's Hyper+O runs send() over hs.ipc (`hs2`), which doesn't activate HS2,
// so frontmost() is the source app. Fallback: `open hammerspoon2://omnifocus`, which does activate
// HS2, so the source app comes from lastSourceApp instead.

const DIR = hs.appinfo.configDir;
// Resolve against configDir, not the CWD (hs.fs.chdir() can move it).
const resolvePath = (p) => (p.startsWith("/") ? p : DIR + "/" + p);

const BUILTIN = {
  outlook: resolvePath("scripts/outlook-to-omnifocus.applescript"),
  evernote: resolvePath("scripts/evernote-to-omnifocus.applescript"),
  mail: resolvePath("scripts/mail-to-omnifocus.applescript"),
  safari: resolvePath("scripts/safari-to-omnifocus.applescript"),
  chrome: {
    type: "template",
    path: resolvePath("scripts/chrome-to-omnifocus.tpl"),
  },
  vivaldi: {
    type: "template",
    path: resolvePath("scripts/chrome-to-omnifocus.tpl"),
  },
};

const APP_KEYS = {
  "Microsoft Outlook": "outlook",
  Evernote: "evernote",
  Mail: "mail",
  Safari: "safari",
  "Google Chrome": "chrome",
  Vivaldi: "vivaldi",
};

const overrides = {};

function resolve(appName) {
  if (overrides[appName]) return { path: overrides[appName] };
  const h = BUILTIN[appName] || BUILTIN[APP_KEYS[appName]];
  return h ? (typeof h === "string" ? { path: h } : h) : null;
}

function setHandler(appName, p) {
  overrides[appName] = resolvePath(p);
}

// Last non-HS2 app to activate: the source app on the URL route.
let lastSourceApp = null;
hs.application.on("didActivate", (app) => {
  if (!app || /Hammerspoon/i.test(app.title || "")) return;
  lastSourceApp = app;
});

async function send() {
  const fm = hs.application.frontmost();
  const fmIsHs2 = fm && /Hammerspoon/i.test(fm.title || "");
  const app = fmIsHs2 ? lastSourceApp : fm;
  const appName = app ? app.title : null;
  const h = resolve(appName);
  if (!h) {
    hs.notify.show("OmniFocus", `No handler for ${appName}`);
    return;
  }
  try {
    if (h.type === "template") {
      const tpl = hs.fs
        .read(h.path, 0, 999999)
        .replace(/\$\{quickentry_open\}/g, "")
        .replace(/\$\{quickentry_close\}/g, "")
        .replace(/\$\{item\}/g, '');
      const r = await hs.osascript.applescript(tpl);
      if (!r.success) throw new Error(r.raw || 'osascript failed');
    } else {
      const r = await hs.task.runAsync('/usr/bin/osascript', [h.path]);
      if (r.exitCode !== 0) throw new Error(r.stderr || `exit ${r.exitCode}`);
    }
    hs.notify.show("OmniFocus", `Filed from ${appName}`);
  } catch (e) {
    hs.notify.show("OmniFocus", `Filing failed: ${e.message}`);
  }
}

hs.permissions.requestNotifications().catch(() => {});

// Exported so pre-0.0.14 HS2 doesn't GC the handler (upstream-issues.md HS2-1).
const __omnifocusHandler = () => {
  send().catch((e) => console.log("[omnifocus] " + e));
};
hs.urlevent.bind("omnifocus", __omnifocusHandler);

module.exports = { send, setHandler, __omnifocusHandler };
