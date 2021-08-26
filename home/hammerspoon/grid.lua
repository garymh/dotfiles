hs.grid.GRIDHEIGHT = 10
hs.grid.GRIDWIDTH  = 10
hs.grid.MARGINX    = 0
hs.grid.MARGINY    = 0
hs.window.animationDuration = 0

left_screen  = hs.screen.find("50FB033E-6ABD-4B3F-954B-F6DC671A41D7")
right_screen = hs.screen.find("02E82278-2E73-4C70-857D-264290C437B9")
main_screen  = hs.screen.find("3B89892E-7540-410A-A7C3-FFE3824A5AED")
macbook      = hs.screen.find("D6D7DC9E-D30E-BFC2-E110-F85B28FF2D3E")

function onMacbook()
  if left_screen == nil then
    return true
  end
end

function drawBorder()
  win = hs.window.focusedWindow()
  if win ~= nil then
    top_left = win:topLeft()
    size = win:size()
    global_border = require("hs.canvas").new({
      x = top_left["x"],
      y = top_left["y"],
      h = size["h"],
      w = size["w"],
    })
      :appendElements({
        action = "build",
        padding = 0,
        type = "rectangle",
      }, {
        action     = "fill",
        fillColor  = { alpha = 0.5, blue = 1.0 },
        frame      = { x = "0", y = "0", h = "1", w = "1" },
        type       = "rectangle",
        withShadow = true,
      })
      :show()
  end
end

function redrawBorder()
  global_border:delete()
  drawBorder()
end

local function set_full_screen()
  win = hs.window.focusedWindow()
  if not win then
    return
  end

  if not win:isFullScreen() then
    win:setFullScreen(true)
  else
    win:setFullScreen(false)
  end
  moom:exit()
end

function moveWindowToDisplay(display)
  local win = hs.window.focusedWindow()

  print(hs.inspect(win))
  if win:isFullScreen() then
    win:setFullScreen(false)
    win:moveToScreen(display, true, false)
    win:setFullScreen(true)
  else
    win:moveToScreen(display, true, false)
  end

  moom:exit()
end

function moveWindowToDisplayAndMaximize(display)
  local win = hs.window.focusedWindow()

  win:moveToScreen(display, true, false)
  hs.grid.maximizeWindow()

  moom:exit()
end

function adjust_moom(x, y, w, h)
  print("x: " .. x .. ", y:" .. y .. ", w:" .. w .. ", h:" .. h)
  print("focusedwindow: " .. hs.inspect(hs.window.focusedWindow()) .. ", main screen: " .. hs.inspect(hs.screen.mainScreen()))
  hs.grid.set(
    hs.window.focusedWindow(),
    { x = x, y = y, w = w, h = h },
    hs.screen.mainScreen()
  )
  moom:exit()
end

function maximizeToLeftScreen() moveWindowToDisplayAndMaximize(left_screen) end
function maximizeToMiddleScreen() moveWindowToDisplayAndMaximize(main_screen) end
function maximizeToRightScreen() moveWindowToDisplayAndMaximize(right_screen) end
function moveToLeftScreen() moveWindowToDisplay(left_screen) end
function moveToMiddleScreen() moveWindowToDisplay(main_screen) end
function moveToRightScreen() moveWindowToDisplay(right_screen) end

moom = hs.hotkey.modal.new({ "cmd" }, "F15", nil)
moom:bind({}, "escape", function() moom:exit() end)
moom:bind({}, "space", function() moom:exit() end)

function moom:entered() drawBorder() end
function moom:exited()
  if global_border then
    global_border:delete()
  end
end

function w_key()
  if hs.screen.mainScreen() == right_screen then
    adjust_moom(0, 3, 10, 4)
  else
    adjust_moom(1, 1, 8, 8)
  end
end

function youtube()
  if onMacbook() then
    adjust_moom(5, 0, 5, 10)
  else
    moveWindowToDisplay(right_screen)
    hs.grid.maximizeWindow()
  end
end

require("layouts")


local function tile_to(direction)
  local app  = hs.application.frontmostApplication()
  local text = "Tile Window to " .. direction .. " of Screen"

  if app:selectMenuItem(text) == nil then
  else
    app:selectMenuItem(text)
  end
  moom:exit()
end

moom:bind({}, "f", set_full_screen)

moom:bind({}, "1", function() moveWindowToDisplay(left_screen) end)
moom:bind({}, "2", function() moveWindowToDisplay(main_screen) end)
moom:bind({}, "3", function() moveWindowToDisplay(right_screen) end)

moom:bind({}, "4", function() tile_to("Left") end)
moom:bind({}, "5", function() tile_to("Right")end)

moom:bind({ "shift" }, "1", function() moveWindowToDisplayAndMaximize(left_screen) end)
moom:bind({ "shift" }, "2", function() moveWindowToDisplayAndMaximize(main_screen) end)
moom:bind({ "shift" }, "3", function() moveWindowToDisplayAndMaximize(right_screen) end)

-- hs.hotkey.bind({ "" }, "pad1", function() moveWindowToDisplay(left_screen) end)
-- hs.hotkey.bind({ "" }, "pad2", function() moveWindowToDisplay(main_screen) end)
-- hs.hotkey.bind({ "" }, "pad3", function() moveWindowToDisplay(right_screen) end)
--
-- hs.hotkey.bind({ "shift" }, "pad5", function() moveWindowToDisplayAndMaximize(left_screen) end)
-- hs.hotkey.bind({ "shift" }, "pad7", function() moveWindowToDisplayAndMaximize(main_screen) end)
-- hs.hotkey.bind({ "shift" }, "pad9", function() moveWindowToDisplayAndMaximize(right_screen) end)
--
-- hs.hotkey.bind({ "" }, "pad5", function() moveWindowToDisplay(left_screen) end)
-- hs.hotkey.bind({ "" }, "pad7", function() moveWindowToDisplay(main_screen) end)
-- hs.hotkey.bind({ "" }, "pad9", function() moveWindowToDisplay(right_screen) end)
--
-- hs.hotkey.bind({ "" }, "pad6", function()
--   if hs.grid.get(hs.window.focusedWindow()) == hs.geometry.rect(0.0, 0.0, 10.0, 10.0)
--   then
--     -- app = hs.application.frontmostApplication()
--     -- if app:selectMenuItem("Zoom") == nil then
--     w_key()
--     -- else
--     --   app:selectMenuItem("Zoom")
--     -- end
--   else
--     hs.grid.maximizeWindow()
--   end
-- end)


-- hs.hotkey.bind({ "" }, "F13", function() useLayout("work") end)
-- hs.hotkey.bind({ "" }, "F14", function() useLayout("game") end)
-- hs.hotkey.bind({ "" }, "F15", function() useLayout("chill") end)

moom:bind({}, "y", youtube)
moom:bind({}, "w", w_key)
moom:bind({}, "d", function() adjust_moom(2, 2, 6, 6) end)

moom:bind({}, "h", function() adjust_moom(0, 0, 5, 10) end)
moom:bind({}, "g", function() adjust_moom(0, 0, 7, 10) end)
moom:bind({}, "l", function() adjust_moom(5, 0, 5, 10) end)
moom:bind({}, ";", function() adjust_moom(3, 0, 7, 10) end)
moom:bind({}, "k", function() adjust_moom(0, 0, 10, 5) end)
moom:bind({}, "j", function() adjust_moom(0, 5, 10, 5) end)
moom:bind({}, "u", function() adjust_moom(0, 0, 5, 5) end)
moom:bind({}, "o", function() adjust_moom(5, 0, 5, 5) end)
moom:bind({}, ".", function() adjust_moom(5, 5, 5, 5) end)
moom:bind({}, "m", function() adjust_moom(0, 5, 5, 5) end)
moom:bind({}, "s", function() adjust_moom(0, 0, 10, 10) end)
-- moom:bind({}, "W", function() useLayout("work") moom:exit() end)
moom:bind({}, "c", function() useLayout("chill") moom:exit() end)
-- moom:bind({}, "!", function() useLayout("superwork") end)

moom:bind({}, "DOWN", function() hs.grid.pushWindowDown() redrawBorder() end)
moom:bind({}, "UP", function() hs.grid.pushWindowUp() redrawBorder() end)
moom:bind({}, "LEFT", function() hs.grid.pushWindowLeft() redrawBorder() end)
moom:bind({}, "RIGHT", function() hs.grid.pushWindowRight() redrawBorder() end)
moom:bind({ "shift" }, "UP", function() hs.grid.resizeWindowShorter() redrawBorder() end)
moom:bind({ "shift" }, "DOWN", function() hs.grid.resizeWindowTaller() redrawBorder() end)
moom:bind({ "shift" }, "RIGHT", function() hs.grid.resizeWindowWider() redrawBorder() end)
moom:bind({ "shift" }, "LEFT", function() hs.grid.resizeWindowThinner() redrawBorder() end)

hs.hotkey.bind({ "shift" }, "F15", function()
  hs.hints.fontName = "Helvetica-BoldOblique"
  hs.hints.fontSize = 16
  moom:exit()
  hs.hints.windowHints()
end)
