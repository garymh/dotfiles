local hyper = { "cmd", "alt", "ctrl", "shift" }

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
  elseif name == 'OmniFocus' then
    if app:selectMenuItem("Hide Sidebar") == nil then
      app:selectMenuItem("Show Sidebar")
    else
      app:selectMenuItem("Hide Sidebar")
    end
  else
    if app:selectMenuItem("Hide Toolbar") == nil then
      app:selectMenuItem("Show Toolbar")
    end
  end
end

function next_song()
  hs.spotify.next()
end

function prev_song()
  hs.spotify.previous()
end

function play_pause()
  hs.spotify.playpause()
end

hs.hotkey.bind(hyper, 'F16', cleanup_key)
hs.hotkey.bind(hyper, 'right', next_song)
hs.hotkey.bind(hyper, 'left', prev_song)
hs.hotkey.bind(hyper, 'down', play_pause)
