require "moom"
require "hyper"
require "controlplane"
require "btt"

local module = {}

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

vpn_bar = hs.menubar.new()
function setVPNDisplay(state)
    if state then
      icon = hs.image.imageFromPath("red.png")
      icon:setSize({w=16,h=16})
      vpn_bar:setTitle("VPN ON  ")
      vpn_bar:setIcon(icon:setSize({w=16,h=16}), false)
    else
      vpn_bar:setTitle("")
      vpn_bar:setIcon(nil)
    end
end

vpn_status = false

local vpnQueryKey = "State:/Network/Interface/ppp0/IPv4"
local isVPNup = function()

  local status = false

  if module.vpnWatcher then
    for k, v in pairs(module.vpnWatcher:contents(vpnQueryKey, true)) do
      for i2, v2 in ipairs(v["Addresses"]) do
        if v2:match("^165%.124%.16[0-9]%.") then
          status = true
          break
        end
      end
      if status then break end
    end
  end
  vpn_status = status
  setVPNDisplay(status)
end
module.vpnWatcher = hs.network.configuration.open():setCallback(isVPNup)
                                        :monitorKeys(vpnQueryKey, true)
                                        :start()

isVPNup()

hs.menuIcon(false)
