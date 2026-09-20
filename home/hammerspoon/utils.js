// ponytail: HS2 require() wraps modules in an IIFE, so a bare function declaration
// stays module-scoped and is invisible to mqtt.js / screens.js. Export via globalThis.
globalThis.isDocked = function isDocked() {
  return hs.usb.attachedDevices().some((d) => d.productName === "TS4 USB2.0 HUB");
};
