zsh_env = "~/.shellenv"

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

 function get_file_name(file)
   return file:match("^.+/(.+)$")
end

hs.console.darkMode(true)
hs.console.consoleFont{name = "FixedsysExcelsiorIIIb Nerd Font", size = 20}
hs.console.outputBackgroundColor{ white = 0 }
hs.console.consoleCommandColor{ white = 1 }

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
      hs.alert("File copied")
    end
  else
  end
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

-- can grid be simplified?
-- hskeybindings
-- ksheet
-- https://www.hammerspoon.org/Spoons/UniversalArchive.html
-- https://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- https://www.hammerspoon.org/Spoons/WindowGrid.html
-- https://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
