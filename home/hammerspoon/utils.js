function isDocked() {
  return hs.usb.attachedDevices().some((d) => d.productName === "TS4 USB2.0 HUB");
}

module.exports = { isDocked };
