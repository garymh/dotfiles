require "moom"
require "hyper"
require "controlplane"
require "btt"

local module = {}
local hyper = { "cmd", "alt", "ctrl", "shift" }

local function _script_path(n)
   if n == nil then n = 2 end
   local str = debug.getinfo(n, "S").source:sub(2)
   return str:match("(.*/)")
end

local function _resource_path(partial)
   return(_script_path(3) .. partial)
 end

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
      quickentrydialog = false,
      notifications = false
    },
    hotkeys = {
      send_to_omnifocus = { hyper, "o" }
    },
    actions =   {
      -- ["Microsoft Outlook"] = {
      --   as_scriptfile = spoon.SendToOmniFocus._resource_path("scripts/outlook-to-omnifocus.applescript"),
      --   itemname = "message"
      -- },
      -- Evernote = {
      --   as_scriptfile = spoon.SendToOmniFocus._resource_path("scripts/evernote-to-omnifocus.applescript"),
      --   itemname = "note"
      -- },
      ["Google Chrome"] = {
        apptype = "chromeapp",
        itemname = "tab"
      },
      Safari = {
        as_scriptfile = _resource_path("scripts/safari-to-omnifocus.applescript"),
        itemname = "message"
      }
    }
  }
)
Install:andUse("Hammer",
               {
                 repo = 'zzspoons',
                 config = {
                  auto_reload_config = true,
                  install_cli = true
                 },
                 hotkeys = {
                   -- config_reload = {hyper, "r"},
                   toggle_console = {hyper, "y"}
                 },
                 start = true
               }
)

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

Install:andUse("FadeLogo",
               {
                 config = {
                   default_run = 1.0,
                 },
                 start = true
               }
               )
