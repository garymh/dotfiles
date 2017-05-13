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
moom:bind({}, 'f', set_full_screen)
moom:bind({}, 'h', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=0, w=5, h=10}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'g', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=0, w=7, h=10}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'l', function()
  hs.grid.set(hs.window.focusedWindow(), {x=5, y=0, w=5, h=10}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, ';', function()
  hs.grid.set(hs.window.focusedWindow(), {x=3, y=0, w=7, h=10}, hs.screen.mainScreen())
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
moom:bind({}, 'u', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=0, w=5, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'o', function()
  hs.grid.set(hs.window.focusedWindow(), {x=5, y=0, w=5, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, '.', function()
  hs.grid.set(hs.window.focusedWindow(), {x=5, y=5, w=5, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
moom:bind({}, 'm', function()
  hs.grid.set(hs.window.focusedWindow(), {x=0, y=5, w=5, h=5}, hs.screen.mainScreen())
  moom:exit()
end)
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
