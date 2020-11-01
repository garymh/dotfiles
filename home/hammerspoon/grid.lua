hs.grid.GRIDHEIGHT          = 10
hs.grid.GRIDWIDTH           = 10
hs.grid.MARGINX             = 0
hs.grid.MARGINY             = 0
hs.window.animationDuration = 0.01

local tall_screen    = hs.screen.find(458678080)
local wide_screen    = hs.screen.find(458627443)
local macbook_screen = hs.screen.find(2077748985)
local hyper          = { "cmd", "alt", "ctrl", "shift" }

function onMacbook()
  if hs.screen.mainScreen() == macbook_screen then
    return true
  else
    return false
  end
end

function drawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
    top_left      = win:topLeft()
    size          = win:size()
    global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'], top_left['y'], size['w'], size['h']))
    global_border:setFillColor({["red"]=0,["blue"]=1,["green"]=0})
    global_border:setFill(true)
    global_border:setAlpha(0.3)
    global_border:show()
  end
end

function redrawBorder()
  global_border:delete()
  drawBorder()
end

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

function moveWindowToDisplay(d)
  local displays = hs.screen.allScreens()
  local win      = hs.window.focusedWindow()
  win:moveToScreen(displays[d], false, true)
  moom:exit()
end

function adjust_moom(x, y, w, h)
  hs.grid.set(hs.window.focusedWindow(), {x=x, y=y, w=w, h=h}, hs.screen.mainScreen())
  moom:exit()
end

moom = hs.hotkey.modal.new({"cmd"}, "f16")
moom:bind({}, 'escape', function() moom:exit() end)
moom:bind({}, 'space',  function() moom:exit() end)

function moom:entered()
  drawBorder()
end

function moom:exited()
  global_border:delete()
end

function youtube()
  if onMacbook() then
    adjust_moom(5, 0, 5,  10)
  else
    moveWindowToDisplay(2)
    hs.grid.maximizeWindow()
  end
end

moom:bind({}, 'f', set_full_screen)

moom:bind({}, '1', function() moveWindowToDisplay(1) end)
moom:bind({}, '2', function() moveWindowToDisplay(2) end)
moom:bind({}, 'y', youtube)
moom:bind({}, 'h', function() adjust_moom(0, 0, 5,  10) end)
moom:bind({}, 'g', function() adjust_moom(0, 0, 7,  10) end)
moom:bind({}, 'l', function() adjust_moom(5, 0, 5,  10) end)
moom:bind({}, ';', function() adjust_moom(3, 0, 7,  10) end)
moom:bind({}, 'k', function() adjust_moom(0, 0, 10, 5) end)
moom:bind({}, 'j', function() adjust_moom(0, 5, 10, 5) end)
moom:bind({}, 'w', function() adjust_moom(1, 1, 8,  8) end)
moom:bind({}, 'd', function() adjust_moom(2, 2, 6,  6) end)
moom:bind({}, 'u', function() adjust_moom(0, 0, 5,  5) end)
moom:bind({}, 'o', function() adjust_moom(5, 0, 5,  5) end)
moom:bind({}, '.', function() adjust_moom(5, 5, 5,  5) end)
moom:bind({}, 'm', function() adjust_moom(0, 5, 5,  5) end)
moom:bind({}, 's', function()
  hs.grid.maximizeWindow()
  moom:exit()
end)

moom:bind({}, 'DOWN',         function() hs.grid.pushWindowDown(); redrawBorder() end)
moom:bind({}, 'UP',           function() hs.grid.pushWindowUp(); redrawBorder() end)
moom:bind({}, 'LEFT',         function() hs.grid.pushWindowLeft(); redrawBorder() end)
moom:bind({}, 'RIGHT',        function() hs.grid.pushWindowRight(); redrawBorder() end)
moom:bind({"shift"}, 'UP',    function() hs.grid.resizeWindowShorter(); redrawBorder() end)
moom:bind({"shift"}, 'DOWN',  function() hs.grid.resizeWindowTaller(); redrawBorder() end)
moom:bind({"shift"}, 'RIGHT', function() hs.grid.resizeWindowWider(); redrawBorder() end)
moom:bind({"shift"}, 'LEFT',  function() hs.grid.resizeWindowThinner(); redrawBorder() end)

hs.hotkey.bind({"shift"}, 'F16', function()
  hs.hints.fontName = "Helvetica-BoldOblique"
  hs.hints.fontSize = 16
  moom:exit()
  hs.hints.windowHints()
end)
