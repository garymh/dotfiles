// caffeine.js — keep-awake toggle: sends hyper+7 to the app bound to that hotkey.
// isActive is only our bookkeeping; the hotkey is a blind toggle, so it drifts if that app is
// toggled by hand.
let isActive = false;

function setState(on) {
  if (on === isActive) return;
  isActive = on;
  hs.eventtap.keyStroke(["ctrl", "cmd", "shift", "alt"], "7");
}

const caffeine = {
  get isActive() { return isActive; },
  enable: () => setState(true),
  disable: () => setState(false),
  toggle: () => setState(!isActive),
};

module.exports = { caffeine };
