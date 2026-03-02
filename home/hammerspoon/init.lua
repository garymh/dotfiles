zsh_env = "~/.shellenv"

hyper = { "cmd", "alt", "ctrl", "shift" }

function sendSystemKey(key)
  hs.eventtap.event.newSystemKeyEvent(key, true):post()
  hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

Calendar         = "com.apple.iCal"
Slack            = "com.tinyspeck.slackmacgap"
Reeder           = "com.reederapp.5.macOS"
Firefox          = "org.mozilla.firefox"
FirefoxDev       = "org.mozilla.firefoxdeveloperedition"
FirefoxNight     = "org.mozilla.nightly"
Zoom             = "us.zoom.xos"
Spotify          = "com.spotify.client"
Kitty            = "net.kovidgoyal.kitty"
SafariTech       = "/Applications/Safari Technology Preview.app"
Safari           = "com.apple.Safari"
GitLabStandalone = "com.webcatalog.juli.gitlab"


hs.allowAppleScript(true)
hs.application.enableSpotlightForNameSearches(true)
hs.console.darkMode(true)

hs.console.consoleFont({ name = "FixedsysExcelsiorIIIb Nerd Font", size = 20 })
hs.console.outputBackgroundColor({ white = 0 })
hs.console.consoleCommandColor({ white = 1 })

function usbDevices()
  devices = hs.usb.attachedDevices()
  print(hs.inspect(devices))
end

function quietReload()
  hs.settings.set("quietReload", true)
  hs.reload()
end

require("hyper")
require("actions")
require("watchers")

function get_file_name(file) return file:match("^.+/(.+)$") end

hs.fileDroppedToDockIconCallback = function(file_string)
  if string.find(file_string, "torrent") then
    uti = hs.fs.fileUTI(file_string)
    extension = hs.fs.fileUTIalternate(uti, "extension")

    if extension == "torrent" then
      filename = get_file_name(file_string)

      if hs.fs.attributes("/Volumes/downloads") == nil then os.execute("open 'smb://oracle/downloads'") end

      hs.timer.waitUntil(function() return hs.fs.attributes("/Volumes/downloads") ~= nil end, function()
        os.execute("cp " .. file_string .. " /Volumes/downloads/torrents/" .. filename)
        os.execute("rm " .. file_string)
        os.execute("open 'smb://oracle/media'")
        hs.alert("File copied")
      end)
    end
  end
end

-- All of the following settings are the defaults and can be omitted.
local SkyRocket = hs.loadSpoon("SkyRocket")

Sky = SkyRocket:new({
  opacity = 0.3,
  enableMove = true,
  moveModifiers = { "cmd", "shift" },
  moveMouseButton = "left",
  resizeModifiers = { "ctrl", "shift" },
  resizeMouseButton = "left",
})

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

Install.repos["gary"] = {
  url = "https://github.com/garymh/Spoons",
  desc = "Gary's Personal Spoons Fork",
  branch = "master",
}

Install:andUse("KSheet")
-- , {
-- 	hotkeys = { toggle = { hyper, "r" } },
-- })

-- Install:andUse("KSheet", {
-- 	hotkeys = {
-- 		toggle = { hyper, "/" },
-- 	},
-- })

Install:andUse("SendToOmniFocus", {
  config = { quickentrydialog = true, notifications = false },
  hotkeys = { send_to_omnifocus = { hyper, "o" } },
  ["repo"] = "gary",
})

local cameras = hs.camera.allCameras()
local webcam = cameras[2] -- Build in MacBook FaceTime HD Camera
if webcam then
  print(cameras[2])
  webcam:setPropertyWatcherCallback(function(camera, property, scope, element)
    print("Camera Property Event: " .. tostring(camera:name()) .. ": " .. tostring(property))
    if camera:isInUse() then
      -- does never happen
      print("Camera in use")
    else
      print("Camera not in use")
    end
  end)
  webcam:startPropertyWatcher()
end

if hs.settings.get("quietReload") ~= true then
  Install:andUse("FadeLogo", { config = { default_run = 1.0 }, start = true })
else
  hs.settings.clear("quietReload")
end

Install:andUse("Caffeine", {})

function caffeineOff()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(false)
  spoon.Caffeine:stop()
end

function caffeineOn()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(true)
end

-- used in Karabiner
function useLayout(layout)
  hs.notify.show("Switching to: " .. layout, "", "", "")

  if layout == "work" then
    caffeineOff()
  elseif layout == "superwork" then
    caffeineOff()
  elseif layout == "meeting" then
  elseif layout == "game" then
    caffeineOn()
  elseif layout == "chill" then
    caffeineOff()
  end
end

-- TODO:
-- Global show/hide hammerspoon dock icon
-- can grid be simplified?
-- hskeybindings
-- ksheet
-- http://www.hammerspoon.org/Spoons/PersonalHotspot.html
-- http://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- http://www.hammerspoon.org/Spoons/USBDeviceActions.html
-- http://www.hammerspoon.org/Spoons/WinWin.html
-- http://www.hammerspoon.org/Spoons/WindowHalfsAndThirds.html
-- http://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
-- http://www.hammerspoon.org/Spoons/VolumeScroll.html
-- http://www.hammerspoon.org/Spoons/ReloadConfiguration.html
-- http://www.hammerspoon.org/Spoons/PushToTalk.html
-- http://www.hammerspoon.org/Spoons/Caffeine.html
-- http://www.hammerspoon.org/Spoons/HSKeybindings.html
-- http://www.hammerspoon.org/Spoons/ModalMgr.htm{
