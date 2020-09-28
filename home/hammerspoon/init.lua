system_ruby = "/Users/gary/.rubies/ruby-2.6.6/bin/ruby"

require "grid"
require "hyper"
require "actions"
require "scenarios"
require "micmute"
require "streamdeck"

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
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

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

Install:andUse("FadeLogo",
               {
                 config = {
                   default_run = 1.0,
                 },
                 start = true
               }
               )

local console     = require("hs.console")
local requirePlus = require("utils.require")
local crash       = require("hs.crash")
local window      = require("hs.window")
local application = require("hs.application")
local logger      = require("hs.logger")
local timer       = require("hs.timer")
local ipc         = require("hs.ipc")
local alert       = require("hs.alert")
local image       = require("hs.image")

window.animationDuration = 0
if console.darkMode() then
    console.outputBackgroundColor{ white = 0 }
    console.consoleCommandColor{ white = 1 }
else
    console.windowBackgroundColor({red=.6,blue=.7,green=.7})
    console.outputBackgroundColor({red=.8,blue=.8,green=.8})
end


-- TODO:

-- can grid be simplified?
-- hskeybindings
-- ksheet
-- https://www.hammerspoon.org/Spoons/UniversalArchive.html
-- https://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- https://www.hammerspoon.org/Spoons/WindowGrid.html
-- https://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
