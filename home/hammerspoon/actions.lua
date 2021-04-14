function action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == 'Mail' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'u')
  elseif name == 'OmniFocus' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'i')
  elseif name == 'Finder' then
    hs.eventtap.keyStroke({'cmd'}, '2')
  elseif name == 'Reeder' then
    hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'l')
  elseif name == 'Messages' then
    app:selectMenuItem("Messages")
    hs.eventtap.keyStroke({'shift', 'alt', 'ctrl', 'cmd'}, '7')
  elseif name == 'MorphVOX' then
    hs.eventtap.keyStroke({'cmd'}, '0')
  elseif name == 'Opera' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Safari' or name == 'Safari Technology Preview' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Tweetbot' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'l')
  elseif name == 'Slack' then
    hs.eventtap.keyStroke({'cmd'}, '.')
  elseif name == 'Microsoft Teams' then
    hs.eventtap.keyStroke({'cmd'}, 'e')
  elseif name == 'Calendar' then
    if app:selectMenuItem("Hide Calendar List") == nil then
      app:selectMenuItem("Show Calendar List")
    else
      app:selectMenuItem("Show Toolbar")
    end
  elseif name == 'iTerm2' or name == "Oni" or name == 'MacVim' or name == 'Alfred 3' or name == "VimR" or name == 'Firefox' or name == 'kitty' or name == "Alacritty" or name == 'Firefox Developer Edition' then
    hs.eventtap.keyStroke({}, 'escape')
  else
    hs.alert("Unknown application")
  end
end

function shift_action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == 'Mail' then
    app:selectMenuItem("Toggle Flag")
  -- elseif name == 'OmniFocus' then
  else
    hs.alert("Unknown application")
  end
    -- hs.alert("woop woop")
  -- app:selectMenuItem("Bring All to Front")
end

hs.hotkey.bind({"shift"}, 'F16', shift_action_key)
hs.hotkey.bind({""}, 'F16', action_key)
