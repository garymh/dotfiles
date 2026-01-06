local geometry   = require("hs.geometry")

bot25            = geometry.rect(0, 0.75, 1, 0.25)
bot50            = geometry.rect(0, 0.5, 1, 0.50)
bot75            = geometry.rect(0, 0.25, 1, 0.75)
top25            = geometry.rect(0, 0, 1, 0.25)
top50            = geometry.rect(0, 0, 1, 0.50)
top75            = geometry.rect(0, 0, 1, 0.75)

bot30            = geometry.rect(0, 0.66666, 1, 0.33333)
center30         = geometry.rect(0.33333, 0, 0.33333, 1)
left30           = geometry.rect(0, 0, 0.33333, 1)
mid30            = geometry.rect(0, 0.33333, 1, 0.33333)
right30          = geometry.rect(0.66666, 0, 0.33333, 1)
top30            = geometry.rect(0, 0, 1, 0.33333)

top_left_corner  = geometry.rect(0, 0, 0.50, 0.50)
top_right_corner = geometry.rect(0.50, 0, 0.50, 0.50)

left30           = hs.layout.left30
left50           = hs.layout.left50
left70           = hs.layout.left70
right30          = hs.layout.right30
right50          = hs.layout.right50
right70          = hs.layout.right70

max              = hs.layout.maximized

function normalDesktop()
  for _, scr in pairs(hs.screen.allScreens()) do
    scr:desktopImageURL("file:///System/Library/CoreServices/DefaultDesktop.heic")
  end
end

function meetingDesktop()
  for _, scr in pairs(hs.screen.allScreens()) do
    scr:desktopImageURL("file:///Users/gary/Documents/Wallpapers/Citrus%20Peel.jpg")
  end
end

function caffeineOff()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(false)
  spoon.Caffeine:stop()
end

function caffeineOn()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(true)
end

function activateApps(table)
  for k, v in pairs(table) do
    hs.application.launchOrFocus(v[1])
  end
end

function addLayout(table)
  for k, v in pairs(table) do
    if v[3] == nil then
      table[k] = nil
    end
  end

  hs.layout.apply(apps)
end

function killApps(table)
  for k, v in pairs(table) do
    app = hs.application.find(v)

    if app then
      app:kill()
    end
  end
end

function CheckCaffeine()
  if hs.host.idleTime() >= 600 then
    caffeineOff()
  end
end

function useLayout(layout)
  hs.notify.show("Switching to: " .. layout, "", "", "")

  if layout == "work" then
    -- normalDesktop()
    caffeineOff()
    local apps = {
      { "SwiftBar",                  nil, nil,          nil,     nil, nil },
      { "Slack",                     nil, left_screen,  right50, nil, nil },
      { "Safari",                    nil, main_screen,  left50,  nil, nil },
      { "kitty",                     nil, main_screen,  right50, nil, nil },
      { "Firefox Developer Edition", nil, right_screen, bot75,   nil, nil },
      { "Mimestream",                nil, right_screen, top25,   nil, nil },
    }
  elseif layout == "superwork" then
    -- normalDesktop()
    caffeineOff()
    local apps = {
      { "SwiftBar",                  nil, nil,          nil,     nil, nil },
      { "Slack",                     nil, left_screen,  right50, nil, nil },
      { "Safari",                    nil, main_screen,  left50,  nil, nil },
      { "kitty",                     nil, main_screen,  right50, nil, nil },
      { "Firefox Developer Edition", nil, right_screen, bot75,   nil, nil },
      { "Mimestream",                nil, right_screen, top25,   nil, nil },
    }
    local killed_apps = { "Firefox", "Messages", "Mail" }
  elseif layout == "meeting" then
    -- meetingDesktop()
  elseif layout == "game" then
    -- normalDesktop()
    caffeineOn()
    local apps = {
      { "Messages", nil, right_screen, top30,    nil, nil },
      { "Slack",    nil, right_screen, mid30,    nil, nil },
      { "Mail",     nil, right_screen, bot30,    nil, nil },
      { "Safari",   nil, left_screen,  max,      nil, nil },
      { "Reeder",   nil, left_screen,  center30, nil, nil },
    }
    local killed_apps = { "Mimestream", "SwiftBar", "Firefox Developer Edition" }
  elseif layout == "chill" then
    -- normalDesktop()
    caffeineOff()
    local apps = {
      { "Safari",   nil, main_screen,  left70,           nil, nil },
      { "Messages", nil, right_screen, top_right_corner, nil, nil },
      { "Mail",     nil, right_screen, top_left_corner,  nil, nil },
      { "Reeder",   nil, right_screen, bot50,            nil, nil },
    }
    local killed_apps = { "Mimestream", "SwiftBar", "Firefox Developer Edition" }
  end

  -- killApps(killed_apps)
  -- activateApps(apps)
  -- addLayout(apps)
end
