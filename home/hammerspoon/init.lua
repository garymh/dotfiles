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

function tablelength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

function showOrHide(application)
  if hs.application.frontmostApplication() == hs.application(application) then
    hs.application(application):hide()
  else
    hs.application.launchOrFocus(application)
  end
end

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

require("grid")
require("hyper")
require("actions")
-- require("scheduling")
-- require("scenarios")
-- require("razer")

function get_file_name(file)
  return file:match("^.+/(.+)$")
end

hs.fileDroppedToDockIconCallback = function(file_string)
  if string.find(file_string, "torrent") then
    uti = hs.fs.fileUTI(file_string)
    extension = hs.fs.fileUTIalternate(uti, "extension")

    if extension == "torrent" then
      filename = get_file_name(file_string)

      if hs.fs.attributes("/Volumes/downloads") == nil then
        os.execute("open 'smb://oracle/downloads'")
      end

      hs.timer.waitUntil(function()
        return hs.fs.attributes("/Volumes/downloads") ~= nil
      end, function()
        os.execute(
          "cp " .. file_string .. " /Volumes/downloads/torrents/" .. filename
        )
        os.execute("rm " .. file_string)
        os.execute("open 'smb://oracle/media'")
        hs.alert("File copied")
      end)
    end
  end
end

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

Install.repos["gary"] = {
  url = "https://github.com/garymh/Spoons",
  desc = "Gary's Personal Spoons Fork",
  branch = "master",
}

Install:andUse("SendToOmniFocus", {
  config = { quickentrydialog = true, notifications = false },
  hotkeys = { send_to_omnifocus = { hyper, "o" } },
  ["repo"] = "gary",
})

-- Install:andUse("MicMute", {
--   hotkeys = { toggle = { {}, "pad0" } },
--   ["repo"] = "gary",
-- })

if hs.settings.get("quietReload") ~= true then
  Install:andUse("FadeLogo", { config = { default_run = 1.0 }, start = true })
else
  hs.settings.clear("quietReload")
end

Install:andUse("Caffeine", {})

function omnifocusContext(paths, flagTables)
  good_path = "/Users/gary/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/Automation/Work"

  if hs.fnutils.contains(paths, good_path) then
    if hs.fs.displayName(good_path) == nil then
    print("REMOVING WORK MODE")
    hs.execute("shortcuts run \"Home Mode\"")
  else
    print("ADDING WORK MODE")
    hs.execute("shortcuts run \"Work Mode\"")
  end
  else
  end
end

local myWatcher = hs.pathwatcher.new(
  os.getenv("HOME") .. "/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/Automation",
  omnifocusContext
  ):start()


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
-- http://www.hammerspoon.org/Spoons/ModalMgr.html
