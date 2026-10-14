// layout.js — hammerspoon2://layout?name=work|superwork|chill|game; watchers/screens.js also calls
// useLayout() directly.
const { caffeine } = require("./caffeine.js");

const KNOWN_LAYOUTS = ["work", "superwork", "chill", "game"];

function useLayout(name) {
  hs.notify.show("Layout", "Switching to: " + name);
  if (["work", "superwork", "chill"].includes(name)) caffeine.disable();
  else if (name === "game") caffeine.enable();
}

// Exported so pre-0.0.14 HS2 doesn't GC the handler (upstream-issues.md HS2-1).
const __layoutHandler = (eventName, params, senderPID, fullURL) => {
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
hs.urlevent.bind("layout", __layoutHandler);

module.exports = { useLayout, __layoutHandler };
