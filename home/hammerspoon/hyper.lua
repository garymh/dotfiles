local function hide_toolbar(app, string)
  app:selectMenuItem("Hide " .. string)
end

local function show_toolbar(app, string)
  app:selectMenuItem("Show " .. string)
end

local function toggle(app, string)
  if app:findMenuItem("Show " .. string) then
    show_toolbar(app, string)
  else
    hide_toolbar(app, string)
  end
end

local function systemKey(key)
  hs.eventtap.event.newSystemKeyEvent(string.upper(key), true):post()
  hs.eventtap.event.newSystemKeyEvent(string.upper(key), false):post()
end

local function cleanup_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()
  if name == "Mail" then
    toggle(app, "Mailbox List")
    toggle(app, "Toolbar")
  elseif name == "OmniFocus" then
    toggle(app, "Sidebar")
  elseif name == "Slack" then
    hs.eventtap.keyStroke({ "shift", "cmd" }, "D")
  else
    toggle(app, "Toolbar")
  end
end

local function show_hide_sicilio()
  if hs.application("Silicio") == nil then
    hs.application.launchOrFocus("Silicio")
  else
    hs.eventtap.keyStroke(Hyper, "5")
  end -- Silicio has its own show/hide thats bound to this key
end

hs.hotkey.bind(Hyper, "F15", cleanup_key)
hs.hotkey.bind(Hyper, "right", function() systemKey("NEXT") end)
hs.hotkey.bind(Hyper, "left", function() systemKey("PREVIOUS") end)
hs.hotkey.bind(Hyper, "up", show_hide_sicilio)
hs.hotkey.bind(Hyper, "down", function() systemKey("PLAY") end)

hs.hotkey.bind(Hyper, "F1", function() systemKey("BRIGHTNESS_DOWN") end)
hs.hotkey.bind(Hyper, "F2", function() systemKey("BRIGHTNESS_UP") end)

local function fullscreen()
  local win = hs.window.focusedWindow()
  if not win then
    return
  end

  win:toggleFullScreen(true)
end

local function mute_firefox_tab()
  local old_app   = hs.application.frontmostApplication()
  local firefoxen = hs.application.applicationsForBundleID("org.mozilla.firefox")
  local firefox   = firefoxen[1]

  firefox:activate()
  hs.timer.usleep(60000)

  hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
  hs.eventtap.event.newKeyEvent("m", true):post()
  hs.eventtap.event.newKeyEvent("m", false):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()

  old_app:activate()
end

hs.hotkey.bind(Hyper, "f", function() fullscreen() end)
hs.hotkey.bind(Hyper, "n", function() mute_firefox_tab() end)
