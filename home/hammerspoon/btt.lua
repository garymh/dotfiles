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
  elseif name == 'MorphVOX' then
    hs.eventtap.keyStroke({'cmd'}, '0')
  elseif name == 'Opera' then
    hs.eventtap.keyStroke({'cmd'}, '0')
  elseif name == 'Safari' or name == 'Safari Technology Preview' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'b')
  elseif name == 'Tweetbot' then
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'l')
  elseif name == 'Firefox' then
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'c')
  elseif name == 'Slack' then
    hs.eventtap.keyStroke({'cmd'}, 't')
  elseif name == 'iTerm2' or name == 'MacVim' then
    hs.eventtap.keyStroke({}, 'escape')
  else
    hs.alert("Unknown application")
  end
end

hs.hotkey.bind({""}, 'F16', action_key)

-- local remap = function(mods, key)
--   return function(j
--     hs.eventtap.keyStroke(mods, key)
--   end
-- end

-- hs.fnutils.each({
--     { key = 'h', fn = "left"  },
--     { key = 'j', fn = "down"  },
--     { key = 'k', fn = "up"    },
--     { key = 'l', fn = "right" },
--   },
--   function(object)
--     hs.hotkey.bind({"ctrl"}, object.key, remap({}, object.fn))
--   end
--   )
