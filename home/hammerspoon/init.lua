zsh_env = "~/.shellenv"

hyper = {"cmd", "alt", "ctrl", "shift"}

function sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

tweetbot  = hs.application "Tweetbot"
tweetbot  = hs.application "Calendar"
slack     = hs.application "Slack"
reeder    = hs.application "Reeder"
firefox   = hs.application "Firefox"
zoom      = hs.application "zoom.us"
spotify   = hs.application "Spotify"
alacritty = hs.application "Alacritty"

function showOrHide(application)
  if hs.application.frontmostApplication() == hs.application(application) then
    hs.application(application):hide()
  else
    hs.application.launchOrFocus(application)
  end
end

require "grid"
require "hyper"
require "actions"
require "knob"

local function _script_path(n)
  if n == nil then n = 2 end
  local str = debug.getinfo(n, "S").source:sub(2)
  return str:match("(.*/)")
end

local function _resource_path(partial) return (_script_path(3) .. partial) end

function get_file_name(file) return file:match("^.+/(.+)$") end

hs.console.darkMode(true)
hs.console.consoleFont {name = "FixedsysExcelsiorIIIb Nerd Font", size = 20}
hs.console.outputBackgroundColor {white = 0}
hs.console.consoleCommandColor {white = 1}

hs.fileDroppedToDockIconCallback = function(file_string)
  if string.find(file_string, "torrent") then
    uti = hs.fs.fileUTI(file_string)
    extension = hs.fs.fileUTIalternate(uti, "extension")
    if extension == "torrent" then
      filename = get_file_name(file_string)
      if hs.fs.attributes("/Volumes/media") == nil then
        os.execute("open 'smb://oracle/media'")
      end
      os.execute("cp " .. file_string .. " /Volumes/media/Torrents/" .. filename)
      os.execute("rm " .. file_string)
      hs.alert("File copied")
    end
  else
  end
end

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

Install.repos["gary"] = {
  url = "https://github.com/garymh/Spoons",
  desc = "Gary's Personal Spoons Fork",
  branch = "master"
}

Install:andUse("SendToOmniFocus", {
  config = {quickentrydialog = true, notifications = false},
  hotkeys = {send_to_omnifocus = {hyper, "o"}},
  ['repo'] = "gary"
})

Install:andUse("MicMute", {['repo'] = "gary"})

require "streamdeck"
Install:andUse("FadeLogo", {config = {default_run = 1.0}, start = true})

local requirePlus = require("utils.require")
local crash       = require("hs.crash")
local window      = require("hs.window")
local application = require("hs.application")
local logger      = require("hs.logger")
local timer       = require("hs.timer")
local ipc         = require("hs.ipc")
local alert       = require("hs.alert")
local image       = require("hs.image")

-- TODO:
-- Global show/hide hammerspoon dock icon
-- can grid be simplified?
-- hskeybindings
-- ksheet
-- https://www.hammerspoon.org/Spoons/UniversalArchive.html
-- https://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- https://www.hammerspoon.org/Spoons/WindowGrid.html
-- https://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
