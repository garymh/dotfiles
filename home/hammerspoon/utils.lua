local M = {}

function M.isDocked()
  return hs.fnutils.some(hs.usb.attachedDevices(), function(device) return device.productName == "TS4 USB2.0 HUB" end)
end

return M
