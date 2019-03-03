function action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == 'Mail' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'f')
  elseif name == 'OmniFocus' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'i')
  elseif name == 'Finder' then
    hs.eventtap.keyStroke({'cmd'}, '2')
  elseif name == 'Reeder' then
    hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'l')
  elseif name == 'Messages' then
    hs.eventtap.keyStroke({'cmd'}, '0')
  -- elseif name == 'MorphVOX' then
  --   hs.eventtap.keyStroke({'cmd'}, '0')
  elseif name == 'Opera' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Safari' or name == 'Safari Technology Preview' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Tweetbot' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'l')
  elseif name == 'Firefox Developer Edition' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'c')
  elseif name == 'Slack' then
    hs.eventtap.keyStroke({'cmd'}, '.')
  elseif name == 'iTerm2' or name == 'MacVim' or name == 'Alfred 3' then
    hs.eventtap.keyStroke({}, 'escape')
  else
    hs.alert("Unknown application")
  end
end

hs.hotkey.bind({""}, 'F16', action_key)
