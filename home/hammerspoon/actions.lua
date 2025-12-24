function action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == "Mail" then
    hs.eventtap.keyStroke({ "shift", "cmd" }, "u")
  elseif name == "OmniFocus" then
    hs.eventtap.keyStroke({ "alt", "cmd" }, "i")
  elseif name == "Finder" then
    hs.eventtap.keyStroke({ "cmd" }, "2")
  elseif name == "Reeder" then
    hs.eventtap.keyStroke({ "ctrl", "cmd" }, "l")
  elseif name == "Messages" then
    app:selectMenuItem("Messages")
    hs.eventtap.keyStroke({ "shift", "alt", "ctrl", "cmd" }, "7")
  elseif name == "Discord" then
    hs.eventtap.keyStroke({ "cmd" }, "k")
  elseif name == "Opera" then
    hs.eventtap.keyStroke({ "shift", "cmd" }, "b")
  elseif name == "Safari" or name == "Safari Technology Preview" then
    hs.eventtap.keyStroke({ "shift", "cmd" }, "b")
  elseif name == "Tweetbot" then
    hs.eventtap.keyStroke({ "shift", "cmd" }, "l")
  elseif name == "1Password" then
    hs.eventtap.keyStroke({ "cmd" }, "r")
  elseif name == "Fantastical" then
    hs.eventtap.keyStroke({ "alt", "cmd" }, "s")
  elseif name == "Slack" then
    hs.eventtap.keyStroke({ "cmd" }, ".")
  elseif name == "Firefox Nightly" then
    hs.eventtap.keyStroke({ "alt" }, "t")
  elseif name == "Plasticity" then
    hs.eventtap.keyStroke({ "ctrl" }, "")
  elseif name == "Calendar" then
    if app:selectMenuItem("Hide Calendar List") == nil then
      app:selectMenuItem("Show Calendar List")
    else
      app:selectMenuItem("Show Toolbar")
    end
  elseif
      name == "iTerm2"
      or name == "Oni"
      or name == "MacVim"
      or name == "Alfred 3"
      or name == "nvim-qt"
      or name == "Firefox"
      or name == "kitty"
      or name == "WezTerm"
      or name == "Ghostty"
      or name == "Alacritty"
      or name == "Neovide"
      or name == "Firefox Developer Edition"
      or name == "goneovim"
      or name == "Neovim"
      or name == "VimR"
      or name == "neovide"
      or name == "Warp"
  then
    hs.eventtap.keyStroke({}, "escape")
  else
    hs.alert("Unknown application")
  end
end

function shift_action_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()

  if name == "Mail" then
    app:selectMenuItem("Toggle Flag")
  elseif name == "Messages" then
    if app:selectMenuItem("Mark as Unread") == nil then
      app:selectMenuItem("Mark as Read")
    else
      app:selectMenuItem("Mark as Unread")
    end
  elseif name == "Reeder" then
    app:selectMenuItem("Sync")
  elseif name == "Safari" then
    hs.eventtap.keyStroke({ "ctrl" }, "e")
  elseif name == "Firefox" then
    hs.eventtap.keyStroke({ "alt" }, "t")
  elseif name == "Firefox Developer Edition" then
    hs.eventtap.keyStroke({ "alt", "cmd" }, "i")
  elseif name == "kitty" or name == "WezTerm" or name == "neovide" then
    hs.eventtap.keyStroke({ "shift" }, "5")
  else
    hs.alert("Unknown application")
  end
end

function hide_application()
  local app = hs.application.frontmostApplication()
  app:hide()
end

function f20() hs.eventtap.keyStroke({ "cmd" }, "h") end

function f13()
  w_key()
  -- local app = hs.application.frontmostApplication()
  -- local name = app:name()
  --
  -- if
  --   name == "Safari"
  --   or name == "Safari Technology Preview"
  --   or name == "Firefox"
  --   or name == "Firefox Developer Edition"
  -- then
  --   hs.eventtap.keyStroke({}, "home")
  -- elseif name == "Slack" then
  --   hs.eventtap.keyStroke({ "cmd" }, "]")
  -- elseif name == "kitty" then
  --   hs.eventtap.keyStroke({ "shift", "cmd" }, "]")
  -- elseif name == "Reeder" then
  --   hs.eventtap.keyStroke({ "alt" }, "2")
  -- elseif name == "Messages" then
  --   hs.eventtap.keyStroke({ "cmd" }, "]")
  -- else
  --   hs.alert("Unknown application")
  -- end
end

function f14()
  s_key()
  -- local app = hs.application.frontmostApplication()
  -- local name = app:name()
  --
  -- if
  --   name == "Safari"
  --   or name == "Safari Technology Preview"
  --   or name == "Firefox"
  --   or name == "Firefox Developer Edition"
  -- then
  --   hs.eventtap.keyStroke({}, "end")
  -- elseif name == "Slack" then
  --   hs.eventtap.keyStroke({ "cmd" }, "[")
  -- elseif name == "kitty" then
  --   hs.eventtap.keyStroke({ "shift", "cmd" }, "[")
  -- elseif name == "Reeder" then
  --   hs.eventtap.keyStroke({ "alt" }, "1")
  -- elseif name == "Messages" then
  --   hs.eventtap.keyStroke({ "cmd" }, "[")
  -- else
  --   hs.alert("Unknown application")
  -- end
end

-- hs.hotkey.bind({ "" },      "F20", f20)

-- hs.hotkey.bind({ "" }, "pad1", function() moveToLeftScreen() end)
-- hs.hotkey.bind({ "" }, "pad2", function() moveToMiddleScreen() end)
-- hs.hotkey.bind({ "" }, "pad3", function() moveToRightScreen() end)

hs.hotkey.bind({ "" }, "F15", action_key)
hs.hotkey.bind({ "alt" }, "F15", hide_application)
hs.hotkey.bind({ "shift" }, "F15", shift_action_key)
hs.hotkey.bind({}, "F13", f13)
-- hs.hotkey.bind({"shift"}, "scrolllock",  f14)

-- hs.hotkey.bind({ "" },      "pad*",  w_key)
-- hs.hotkey.bind({ "" },      "pad-", function() adjust_moom(2, 2, 6, 6) end)
-- hs.hotkey.bind({ "" }, "padenter", function() adjust_moom(0, 0, 10, 10) end)
