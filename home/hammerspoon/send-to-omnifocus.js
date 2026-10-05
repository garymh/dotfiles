// send-to-omnifocus.js — Hyper+O files the current item to OmniFocus via per-app AppleScript.

// ponytail: resolve relative paths against hs.appinfo.configDir — CWD is not guaranteed to be the config dir.
const DIR = hs.appinfo.configDir;
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

// ponytail: HS2 require() wraps modules in an IIFE; setHandler must be on globalThis for init.js to see it.
globalThis.setHandler = function setHandler(appName, p) {
  overrides[appName] = resolvePath(p);
};

// Cache the most recent non-HS2 active app. The URL path (Karabiner → `open
// hammerspoon2://…` → urlevent callback) activates HS2 to handle the URL, so
// `hs.application.frontmost()` inside send() returns "Hammerspoon 2" — the
// user's source app is the one that *was* frontmost (Safari, Mail, etc.).
// The cache is updated on every didActivate event for any app that isn't HS2.
let lastSourceApp = null;
// ponytail: 0.0.13 replaced hs.application.addWatcher(cb) with one on(event, cb) per event.
hs.application.on("didActivate", (app) => {
  if (!app) return;
  const name = app.title;  // HSApplication has .title; .name is undefined
  if (!name || /Hammerspoon/i.test(name)) return;
  lastSourceApp = app;
});

async function send() {
  // Prefer the cached source app; fall back to frontmost() only if the cache
  // is empty AND frontmost isn't HS2 itself.
  const fm = hs.application.frontmost();
  const fmIsHs2 = fm && /Hammerspoon/i.test(fm.title || "");
  const app = lastSourceApp || (!fmIsHs2 ? fm : null);
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
      // ponytail: hs.osascript returns {success, result, raw} — no .stderr.
      const r = await hs.osascript.applescript(tpl);
      if (!r.success) throw new Error(r.raw || 'osascript failed');
    } else {
      // ponytail: hs.task.shell takes a string; use runAsync with argv array.
      const r = await hs.task.runAsync('/usr/bin/osascript', [h.path]);
      if (r.exitCode !== 0) throw new Error(r.stderr || `exit ${r.exitCode}`);
    }
    hs.notify.show("OmniFocus", `Filed from ${appName}`);
  } catch (e) {
    hs.notify.show("OmniFocus", `Filing failed: ${e.message}`);
  }
}

hs.permissions.requestNotifications().catch(() => {});
// Trigger: Karabiner's Hyper+O rule (in rules/hammerspoon-ports.ts) opens
// `hammerspoon2://omnifocus`, which HS2's urlevent module dispatches to the
// handler below. The URL dispatch activates HS2 to receive the Apple Event,
// so frontmost() in send() returns HS2; the application watcher above caches
// the user's source app on every didActivate, and send() uses that cache.
// (HS2 urlevent: see the pin note further down — the JSFunction otherwise GC's
// within ~60-90s of bind.)
//
// (Same pattern as the `layout` binding in layout.js — and same GC pin.)
globalThis.__omnifocusHandler = () => {
  console.log("[omnifocus] url received, calling send()");
  send();
};
hs.urlevent.bind("omnifocus", globalThis.__omnifocusHandler);
