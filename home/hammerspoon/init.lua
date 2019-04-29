require "moom"
require "hyper"
require "controlplane"
require "btt"

local module = {}
local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall
Install:andUse("TimeMachineProgress",
  {
    start = true
  }
  )
Install:andUse("SendToOmniFocus",
  {
    config = {
      quickentrydialog = true,
      notifications = true
    },
    hotkeys = {
      send_to_omnifocus = { hyper, "o" }
    },
    -- fn = function(s)
    --   s:registerApplication("Swisscom Collab", { apptype = "chromeapp", itemname = "tab" })
    --   s:registerApplication("Swisscom Wiki", { apptype = "chromeapp", itemname = "wiki page" })
    --   s:registerApplication("Swisscom Jira", { apptype = "chromeapp", itemname = "issue" })
    --   s:registerApplication("Brave Browser Dev", { apptype = "chromeapp", itemname = "page" })
    -- end
  }
  )

-- hs.ipc.cliInstall()

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

-- local mods = {
--   'wifi',
-- }

-- modules = {}

-- for key, mod in ipairs(mods) do
--   modules[mod] = require('mods/' .. mod)
--   modules[mod].start()
--   hs.printf('Started module ' .. mod)
-- end


-- mash = {"cmd", "alt", "ctrl", "shift"}
-- -- Ensure everything is loaded before hiding the icon :)
-- -- Show/Hide menu icon
-- hs.hotkey.bind(mash, "7", function()
--   hs.menuIcon(not hs.menuIcon())
--   local wifiName = hs.wifi.currentNetwork()
--   local security = hs.wifi.interfaceDetails().security
--   local interface = hs.wifi.interfaceDetails()

--   hs.inspect("wifi name:" .. wifiName)
--   hs.inspect("security" .. security)
--   hs.inspect("interface" .. interface)
-- end)

vpn_bar = hs.menubar.new()
function setVPNDisplay(state)
    if state then
      icon = hs.image.imageFromPath("red.png")
      icon:setSize({w=16,h=16})
      -- vpn_bar:setTitle("🔴️ VPN ON 🔴️")
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
