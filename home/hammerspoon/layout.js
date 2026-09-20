// layout.js — port of layout.lua.
// HS2 require() wraps modules in an IIFE, so useLayout must live on globalThis to be
// visible to screens.js (which calls `useLayout("game")` / `useLayout("work")`).
// The layout event is also bound to hs.urlevent so external scripts can trigger layouts via
// hammerspoon2://layout?name=work|superwork|chill|game.
const KNOWN_LAYOUTS = ["work", "superwork", "chill", "game"];

globalThis.useLayout = function useLayout(name) {
  // ponytail: hs.notify.show(title, body, callback) — both args required.
  hs.notify.show("Layout", "Switching to: " + name);
  if (["work", "superwork", "chill"].includes(name)) caffeine.disable();
  else if (name === "game") caffeine.enable();
};

// HS2 urlevent: the JSCallback wrapper doesn't JSManagedValue-anchor the JSFunction, so an
// inline arrow passed to bind() gets GC'd within ~60-90s (silent dispatch no-op). Pin the
// handler to globalThis so the JSFunction stays rooted. Same pattern as send-to-omnifocus.js.
globalThis.__layoutHandler = (eventName, params, senderPID, fullURL) => {
  const name = params && params.name;
  if (!name) {
    hs.notify.show("Layout", "Missing name (use ?name=work|superwork|chill|game)");
    return;
  }
  if (!KNOWN_LAYOUTS.includes(name)) {
    hs.notify.show("Layout", "Unknown layout: " + name + " (use ?name=work|superwork|chill|game)");
    return;
  }
  useLayout(name);
};
hs.urlevent.bind("layout", globalThis.__layoutHandler);
