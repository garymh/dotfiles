function hide_toolbar(app, string) app:selectMenuItem("Hide " .. string) end
function show_toolbar(app, string) app:selectMenuItem("Show " .. string) end

function toggle(app, string)
    if show_toolbar(app, string) then
        show_toolbar(app, string)
    else
        hide_toolbar(app, string)
    end
end

function systemKey(key)
	hs.eventtap.event.newSystemKeyEvent(string.upper(key), true):post()
	hs.eventtap.event.newSystemKeyEvent(string.upper(key), false):post()
end

function cleanup_key()
    local app = hs.application.frontmostApplication()
    local name = app:name()
    if name == 'Mail' then
        toggle(app, "Mailbox List")
        toggle(app, "Toolbar")
    elseif name == 'OmniFocus' then
        toggle(app, "Sidebar")
    elseif name == 'Slack' then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'D')
    else
        toggle(app, "Toolbar")
    end
end

function next_song() hs.spotify.next() end

function prev_song() hs.spotify.previous() end

function play_pause() hs.spotify.playpause() end

function show_hide_sicilio()
  if hs.application "Silicio" == nil then
    hs.application.launchOrFocus("Silicio")
  else
    hs.eventtap.keyStroke(hyper, '5')
  end -- Silicio has its own show/hide thats bound to this key
end

hs.hotkey.bind(hyper, 'F16', cleanup_key)
hs.hotkey.bind(hyper, 'right', function() systemKey("NEXT") end)
hs.hotkey.bind(hyper, 'left', function() systemKey("PREVIOUS") end)
hs.hotkey.bind(hyper, 'up', show_hide_sicilio)
hs.hotkey.bind(hyper, 'down', function() systemKey("PLAY") end)
