local function app()
  return hs.application.frontmostApplication()
end

local function load_actions()
  local f = io.open(hs.configdir .. "/actions.json", "r")
  local raw = f:read("*a")
  f:close()
  return hs.json.decode(raw)
end

local cfg = load_actions()

local function dispatch(map, app, name)
  local entry = map[name]
  if not entry then return false end
  if entry.type == "keystroke" then
    hs.eventtap.keyStroke(entry.mods, entry.key)
  elseif entry.type == "menu" then
    app:selectMenuItem(entry.item)
  end
  return true
end

function action_key()
  local name = app():name()
  if dispatch(cfg.action, app, name) then return end

  hs.alert("Unknown application")
end

function shift_action_key()
  local name = app():name()
  if dispatch(cfg.shift_action, app, name) then return end

  hs.alert("Unknown application")
end

function hide_application()
  app():hide()
end

hs.hotkey.bind({ "" }, "F15", action_key)
hs.hotkey.bind({ "alt" }, "F15", hide_application)
hs.hotkey.bind({ "shift" }, "F15", shift_action_key)
