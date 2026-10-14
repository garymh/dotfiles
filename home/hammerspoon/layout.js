// layout.js — hammerspoon2://layout?name=work|superwork|chill|game; watchers/screens.js also calls
// useLayout() directly.
const { caffeine } = require("./caffeine.js");

const KNOWN_LAYOUTS = ["work", "superwork", "chill", "game"];

function useLayout(name) {
  hs.notify.show("Layout", "Switching to: " + name);
  if (["work", "superwork", "chill"].includes(name)) caffeine.disable();
  else if (name === "game") caffeine.enable();
}

hs.urlevent.bind("layout", (eventName, params) => {
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
});

module.exports = { useLayout };
