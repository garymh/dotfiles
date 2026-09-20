// caffeine.js — menubar toggle for display-sleep prevention.
let isActive = false;
let menubarItem = null;
const ICON_DIR = hs.appinfo.configDir;

function setState(on) {
  if (on === isActive) return;
  isActive = on;
  on ? hs.power.preventSleep("display") : hs.power.allowSleep("display");
  if (!menubarItem) {
    menubarItem = hs.menubar.create();
    menubarItem.setClickCallback(() => caffeine.toggle());
  }
  // ponytail: HS2 setIcon requires an HSImage, not a path string.
  menubarItem.setIcon(HSImage.fromPath(ICON_DIR + (on ? "/caffeine-on.pdf" : "/caffeine-off.pdf")));
}

// ponytail: HS2 require() wraps modules in an IIFE, so only globals are reachable from
// layout.js and from the console (which evaluates via JSEngine.shared.eval on the same
// JSContext as this config). isActive/menubarItem stay module-private.
globalThis.caffeine = {
  get isActive() { return isActive; },
  enable: () => setState(true),
  disable: () => setState(false),
  toggle: () => setState(!isActive),
};
