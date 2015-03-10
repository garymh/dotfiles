local appfinder    = require "hs.appfinder"
local hotkey       = require "hs.hotkey"
local alert        = require "hs.alert"
local applescript  = require "hs.applescript"
local application  = require "hs.application"
local window       = require "hs.window"

omni = hs.hotkey.modal.new({}, "f17")
moom = hs.hotkey.modal.new({"cmd"}, "f16")

function omni:entered()
  alert.show("Adding new task:")
end
function omni:exited()
end

local hyper = {"cmd", "alt", "ctrl", "shift" }

-- hotkey.bind(hyper, 'd', opendictionary)
moom:bind({}, 'escape', function() moom:exit() end)
omni:bind({}, 'escape', function() omni:exit() end)

local function add_task(task_type)
  applescript("tell application \"Alfred 2\" to run trigger \"" .. task_type .. "\" in workflow \"com.garys.stuff\"")
  omni:exit()
end

local function generic_task() add_task("generic") end
local function mac_task() add_task("mac") end
local function home_task() add_task("home") end
local function nufin_task() add_task("nufin") end
local function space_task() add_task("space") end
local function puppy_task() add_task("puppy") end
local function store_task() add_task("store") end
local function clean_task() add_task("clean") end
local function work_task() add_task("work") end

local function set_full_screen()
  win = window.focusedWindow()
  if not win then return end

  if not win:isFullScreen() then
    win:setFullScreen(true)
  else
    win:setFullScreen(false)
  end
  moom:exit()
end

-- omnifocus
omni:bind({}, 'f17', generic_task)
omni:bind({}, 'm', mac_task)
omni:bind({}, 'h', home_task)
omni:bind({}, 'n', nufin_task)
omni:bind({}, 's', space_task)
omni:bind({}, 'p', puppy_task)
omni:bind({}, 'space', store_task)
omni:bind({}, 'c', clean_task)
omni:bind({}, 'w', work_task)
omni:bind({}, 'f17', generic_task)

moom:bind({}, 'f', set_full_screen)

function reload_config(files)
  hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")


moom:bind({}, "f16", function()
  hs.hints.fontName = "Helvetica-BoldOblique"
  hs.hints.fontSize = 16
  moom:exit()
  hs.hints.windowHints()
end)

moom:bind({}, "h", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "l", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "j", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "k", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "y", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "u", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "n", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "b", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "w", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w * (1/12))
  f.y = max.y + (max.h * (1/12))
  f.w = max.w * 5 / 6
  f.h = max.h * 5 / 6
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "d", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w * (1/6))
  f.y = max.y + (max.h * (1/6))
  f.w = max.w * 2 / 3
  f.h = max.h * 2 / 3
  win:setFrame(f)
  moom:exit()
end)

moom:bind({}, "s", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
  moom:exit()
end)

function applicationWatcher(appName, eventType, appObject)
if (eventType == hs.application.watcher.activated) then
    if (appName == "Finder") then
        -- Bring all Finder windows forward when one gets activated
        appObject:selectMenuItem({"Window", "Bring All to Front"})
    end
end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
