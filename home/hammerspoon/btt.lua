function action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == 'Mail' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'f')
  elseif name == 'OmniFocus' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'i')
  elseif name == 'Reeder' then
    hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'l')
  elseif name == 'Safari' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Tweetbot' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'l')
  elseif name == 'Slack' then
    hs.eventtap.keyStroke({'cmd'}, 't')
  else
    -- hs.eventtap.keyStroke({}, 'f18')
    do return end
  end
end

function cleanup_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == 'Mail' then
    if app:selectMenuItem("Hide Mailbox List") == nil then
      app:selectMenuItem("Show Mailbox List")
    end
    if app:selectMenuItem("Hide Toolbar") == nil then
      app:selectMenuItem("Show Toolbar")
    end
  else
    if app:selectMenuItem("Hide Toolbar") == nil then
      app:selectMenuItem("Show Toolbar")
    end
  end
end

local hyper = {"cmd", "alt", "ctrl", "shift" }
hs.hotkey.bind('', 'f18', function() action_key() end)
hs.hotkey.bind(hyper, 'f18', function() cleanup_key() end)
