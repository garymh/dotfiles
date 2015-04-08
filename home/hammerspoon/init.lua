local hyper = {"cmd", "alt", "ctrl", "shift" }

hs.grid.GRIDHEIGHT = 10
hs.grid.GRIDWIDTH = 10
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.window.animationDuration = 0

hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)

-- moom-like functionality
moom = hs.hotkey.modal.new({"cmd"}, "f16")
moom:bind({}, 'escape', function() moom:exit() end)

-- replace caffeine (taken from @BrianGilbert)
-- (via https://github.com/BrianGilbert/.hammerspoon/blob/master/init.lua)
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("caffeine-on.pdf")
    else
        result = caffeine:setIcon("caffeine-off.pdf")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
--
-- /replace caffeine
--

local function set_full_screen()
  win = hs.window.focusedWindow()
  if not win then return end

  if not win:isFullScreen() then
    win:setFullScreen(true)
  else
    win:setFullScreen(false)
  end
  moom:exit()
end
moom:bind({}, 'f', set_full_screen)
moom:bind({}, 'h', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=0, w=5, h=10}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'l', function()
  hs.grid.set(hs.window.focusedWindow(), {x=5, y=0, w=5, h=10}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'k', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=0, w=10, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'j', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=5, w=10, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'w', function()
  hs.grid.set(hs.window.focusedWindow(), {x=1, y=1, w=8, h=8}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'd', function()
  hs.grid.set(hs.window.focusedWindow(), {x=2, y=2, w=6, h=6}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 's', function()
  hs.grid.maximizeWindow()
  moom:exit()
end)

moom:bind({}, "f16", function()
  hs.hints.fontName = "Helvetica-BoldOblique"
  hs.hints.fontSize = 16
  moom:exit()
  hs.hints.windowHints()
end)

-- function moom:entered()
-- end

-- omnifocus
omni = hs.hotkey.modal.new({}, "f17")
omni:bind({}, 'escape', function() omni:exit() end)

function omni:entered()
  hs.alert.show("Adding new task:")
end
-- function omni:exited()
-- end

local function add_task(task_type)
  hs.applescript("tell application \"Alfred 2\" to run trigger \"" .. task_type .. "\" in workflow \"com.garys.stuff\"")
  omni:exit()
end

omni:bind({}, 'f17',   function() add_task("generic") end)
omni:bind({}, 'm',     function() add_task("mac")     end)
omni:bind({}, 'h',     function() add_task("home")    end)
omni:bind({}, 'n',     function() add_task("nufin")   end)
omni:bind({}, 'l',     function() add_task("members") end)
omni:bind({}, 's',     function() add_task("space")   end)
omni:bind({}, 'p',     function() add_task("puppy")   end)
omni:bind({}, 'space', function() add_task("store")   end)
omni:bind({}, 'c',     function() add_task("clean")   end)
omni:bind({}, 'w',     function() add_task("work")    end)

-- reloader
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
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send():release()

