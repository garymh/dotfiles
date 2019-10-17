hs.grid.GRIDHEIGHT          = 10
hs.grid.GRIDWIDTH           = 10
hs.grid.MARGINX             = 0
hs.grid.MARGINY             = 0
hs.window.animationDuration = 0.01

-- moom-like functionality
moom = hs.hotkey.modal.new({"cmd"}, "f16")
moom:bind({}, 'escape', function() moom:exit() end)
moom:bind({}, 'space', function() moom:exit() end)

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

function adjust_moom (x, y, w, h)
  hs.grid.set(hs.window.focusedWindow(), {x=x, y=y, w=w, h=h}, hs.screen.mainScreen())
  moom:exit()
end


moom:bind({}, 'f', set_full_screen)
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

moom:bind({}, 'DOWN', hs.grid.pushWindowDown)
moom:bind({}, 'UP', hs.grid.pushWindowUp)
moom:bind({}, 'LEFT', hs.grid.pushWindowLeft)
moom:bind({}, 'RIGHT', hs.grid.pushWindowRight)
moom:bind({"shift"}, 'UP', hs.grid.resizeWindowShorter)
moom:bind({"shift"}, 'DOWN', hs.grid.resizeWindowTaller)
moom:bind({"shift"}, 'RIGHT', hs.grid.resizeWindowWider)
moom:bind({"shift"}, 'LEFT', hs.grid.resizeWindowThinner)

hs.hotkey.bind({"shift"}, 'F16', function()
  hs.hints.fontName = "Helvetica-BoldOblique"
  hs.hints.fontSize = 16
  moom:exit()
  hs.hints.windowHints()
end)

function moom:entered()
  hs.alert("Resize")
end
