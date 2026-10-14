// mail-vim.js — publishes the Karabiner variable `mail_viewer` for karabiner/rules/mail-vim.ts:
// 1 while Mail is frontmost, its focused window is a message viewer and keyboard focus is outside
// the search field; 0 otherwise. Karabiner alone only knows the frontmost app, which is also Mail
// in compose windows and the search field. This module is the only writer of `mail_viewer`.
const MAIL_BUNDLE_ID = "com.apple.mail";
const KARABINER_VAR = "mail_viewer";
const KARABINER_CLI =
  "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli";
// Viewer windows are Mail.messageViewer.window.<n>; compose windows get generic AppKit ids.
const VIEWER_WINDOW_ID = "Mail.messageViewer.window";
// Window close has no AX notification, hence the noisy uIElementDestroyed; every event is
// coalesced through one short timer.
const AX_EVENTS = [
  hs.ax.notificationTypes.focusedWindowChanged,
  hs.ax.notificationTypes.mainWindowChanged,
  hs.ax.notificationTypes.focusedUIElementChanged,
  hs.ax.notificationTypes.windowCreated,
  hs.ax.notificationTypes.uIElementDestroyed,
];
const COALESCE = 0.05;
const DEBUG = false;

// Debug log goes to a file: console output is <private> in the unified log (upstream-issues.md HS2-5).
let lastDebug = null;
function debug(line) {
  if (!DEBUG || line === lastDebug) return;
  lastDebug = line;
  hs.fs.append("/tmp/mail-vim.log", Date.now() + " " + line + "\n");
}

let published = null;
let cliTask = null;
let focusTimer = null;
let coalesceTimer = null;
let watchedElement = null;

// One long-lived `karabiner_cli --set-variables-from-stdin` reads a JSON object per line; if it
// exits, the next publish() respawns it. The optional create() slots are omitted, not null
// (upstream-issues.md HS2-2).
function onCliExit(exitCode, reason) {
  cliTask = null;
  published = null;
  console.error("[mail-vim] karabiner_cli exited: " + exitCode + " " + reason);
}

function cli() {
  if (cliTask && cliTask.isRunning) return cliTask;
  cliTask = hs.task.create(KARABINER_CLI, ["--set-variables-from-stdin"], onCliExit);
  cliTask.start();
  return cliTask;
}

function publish(value) {
  if (value === published) return;
  published = value;
  debug(KARABINER_VAR + "=" + value);
  cli().sendInput(JSON.stringify({ [KARABINER_VAR]: value }) + "\n");
}

function inMessageViewer() {
  const win = hs.window.focusedWindow();
  if (!win) return false;
  const element = win.axElement();
  const identifier = element && element.attributeValue("AXIdentifier");
  debug("window id=" + identifier);
  return typeof identifier === "string" &&
    identifier.startsWith(VIEWER_WINDOW_ID);
}

function searchFieldFocused() {
  const app = hs.application.matchingBundleID(MAIL_BUNDLE_ID);
  const element = app && app.axElement();
  const focused = element && element.attributeValue("AXFocusedUIElement");
  const subrole = focused && focused.attributeValue("AXSubrole");
  debug("focused subrole=" + subrole);
  return subrole === "AXSearchField";
}

function evaluate() {
  const front = hs.application.frontmost();
  if (!front || front.bundleID !== MAIL_BUNDLE_ID) {
    publish(0);
    return;
  }
  publish(inMessageViewer() && !searchFieldFocused() ? 1 : 0);
}

// Mail has no key that leaves its search field, so the Karabiner escape rule also sends F20 and
// this focuses the message list. The walk skips the roles with expensive subtrees; it reaches the
// list's AXTable in ~30 elements.
const LEAF_ROLES = new Set([
  "AXTable",
  "AXOutline",
  "AXRow",
  "AXCell",
  "AXWebArea",
]);

function findMessageList(root, maxDepth) {
  const queue = [[root, 0]];
  while (queue.length) {
    const [node, depth] = queue.shift();
    const role = node.role;
    if (role === "AXTable") return node;
    if (depth >= maxDepth || LEAF_ROLES.has(role)) continue;
    let kids = [];
    try {
      kids = node.children() || [];
    } catch (e) {
      continue;
    }
    for (const kid of kids) queue.push([kid, depth + 1]);
  }
  return null;
}

function focusMessageList() {
  if (!inMessageViewer()) return;
  const win = hs.window.focusedWindow();
  const root = win && win.axElement();
  if (!root) return;
  const list = findMessageList(root, 8);
  if (!list) {
    debug("message list not found");
    return;
  }
  list.setAttributeValue("AXFocused", true);
  debug("focused message list");
}

function focusListHotkey() {
  const front = hs.application.frontmost();
  debug("focus hotkey, front=" + (front && front.bundleID));
  if (!front || front.bundleID !== MAIL_BUNDLE_ID) return;
  // Let Mail handle the escape that came with this F20 first.
  if (focusTimer) focusTimer.stop();
  focusTimer = hs.timer.doAfter(0.1, () => {
    focusTimer = null;
    focusMessageList();
  });
}

// F20 rather than F19: upstream-issues.md HK-1.
if (!hs.hotkey.bind([], "f20", focusListHotkey)) {
  console.error("[mail-vim] could not bind the F20 focus-list hotkey");
}

function onAxEvent() {
  if (coalesceTimer) return;
  coalesceTimer = hs.timer.doAfter(COALESCE, () => {
    coalesceTimer = null;
    evaluate();
  });
}

function watchMail(app) {
  if (watchedElement) return;
  const element = app && app.axElement();
  if (!element) return;
  try {
    hs.ax.on(element, AX_EVENTS, onAxEvent);
    watchedElement = element;
    debug("watching Mail");
  } catch (e) {
    console.error("[mail-vim] hs.ax.on failed: " + e);
  }
}

function unwatchMail() {
  const element = watchedElement;
  if (!element) return;
  watchedElement = null;
  try {
    hs.ax.off(element, AX_EVENTS, onAxEvent);
  } catch (e) {
    console.error("[mail-vim] hs.ax.off failed: " + e);
  }
}

hs.application.on("didActivate", (app) => {
  if (app && app.bundleID === MAIL_BUNDLE_ID) watchMail(app);
  evaluate();
});
hs.application.on("didLaunch", (app) => {
  if (app && app.bundleID === MAIL_BUNDLE_ID) watchMail(app);
});
hs.application.on("didTerminate", (app) => {
  if (app && app.bundleID !== MAIL_BUNDLE_ID) return;
  unwatchMail();
  publish(0);
});

// Mail is usually already running when the config loads.
watchMail(hs.application.matchingBundleID(MAIL_BUNDLE_ID));
evaluate();
