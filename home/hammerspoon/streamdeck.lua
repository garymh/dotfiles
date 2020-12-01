icons_path = "~/iCloud/Storage/streamdeck_icons/"

function streamDeckImage(filename)
  return hs.image.imageFromPath(icons_path .. filename)
end

function checkMute()
  if zoom then
    print("fart")
    if zoom:findMenuItem'Unmute Audio' then
      print("bonza")
      return true
    else
      return false
    end
  else
    return hs.audiodevice.defaultInputDevice():muted()
  end
end

function anyDistractions()
end

function killDistractions(bool)
  distractions = {tweetbot, slack, reeder, firefox}

  if bool == true then
    for _index, app in pairs(distractions) do
      if app then
        app:kill()
      end
    end
  else
  end
end

function openGitlabScript(script)
  hs.execute("source " .. zsh_env .. " && ~/.zsh/bin/" .. script)
end

function toggleThing(deck, isDown)
  if isDown then
    deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.orange)
  else
    if hs.eventtap.checkKeyboardModifiers().cmd then
      deck:reset()
      deck:setBrightness(0)
      hs.settings.set("deck", nil)
    else
      if hs.settings.get("toggle") == true then
        hs.settings.set("toggle", nil)
        streamDeck:setButtonImage(button, off_image)
      else
        hs.settings.set("toggle", true)
        streamDeck:setButtonImage(button, on_image)
      end
    end
    -- deck:setButtonImage(2, hs.image.imageFromPath(""))
    -- hs.application.launchOrFocus("iTerm")
  end
end

function deckButtonEvent(deck, button, isDown)

  if hs.settings.get("deck") == nil then
    initialScreen(deck)
    hs.settings.set("deck", true)
  else

    if button == 1 then
      zoomClose(deck, isDown)
    end
    if button == 2 then
      if isDown then
        deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.steelblue)
      else
        deck:setButtonImage(button, iterm_image)
        hs.application.launchOrFocus("Alacritty")
      end
    end
    if button == 3 then
      if isDown then
        deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.yellow)
      else
        deck:setButtonImage(button, streamDeckImage(os.date('%d') .. ".png"))
        hs.application.launchOrFocus("Calendar")
      end
    end
    if button == 4 then
      if isDown then
        deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.seagreen)
      else
        deck:setButtonImage(button, issue_image)
        if hs.eventtap.checkKeyboardModifiers().cmd then
          hs.urlevent.openURL("https://gitlab.com/dashboard/issues?assignee_username=garyh")
        else
          openGitlabScript('glissue')
        end
      end
    end
    if button == 5 then
      if isDown then
        deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.darkslateblue)
      else
        deck:setButtonImage(button, mr_image)
        if hs.eventtap.checkKeyboardModifiers().cmd then
          hs.urlevent.openURL("https://gitlab.com/dashboard/merge_requests?assignee_username=garyh")
        else
          openGitlabScript('glmr')
        end
      end
    end
    if button == 6 then
      if isDown then
        if checkMute() then
          deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.red)
        else
          deck:setButtonColor(button, hs.drawing.color.definedCollections.x11.steelblue)
        end
      else
        toggleMicMute()
        if checkMute() then
          deck:setButtonImage(button, mute_on_image)
        else
          deck:setButtonImage(button, mute_off_image)
        end
      end
    end
  end
end

function appCallback(watcher)
end

function initialScreen(deck)
  streamDeck = deck
  streamDeck:setBrightness(100)
  streamDeck:setButtonImage(1, on_image)
  streamDeck:setButtonImage(2, iterm_image)
  streamDeck:setButtonImage(3, streamDeckImage(os.date('%d') .. ".png"))
  streamDeck:setButtonImage(4, issue_image)
  streamDeck:setButtonImage(5, mr_image)
  if checkMute() then
    streamDeck:setButtonImage(6, mute_on_image)
  else
    streamDeck:setButtonImage(6, mute_off_image)
  end
end

function streamDeckDiscovery(isConnect, deck)
  if isConnect then
    -- print("Stream Deck connected: "..tostring(deck))
    streamDeck = deck
    streamDeck:reset()
    streamDeck:setBrightness(100)
    streamDeck:buttonCallback(deckButtonEvent)

    initialScreen(deck)

    -- check

    -- spoon.StreamDeckMicMuter:start(streamDeck, 6)
    -- spoon.StreamDeckAudioDeviceCycle:start(streamDeck, 5)
  else
    -- print("Stream Deck disconnected")
    -- spoon.StreamDeckMicMuter:stop()
    -- spoon.StreamDeckAudioDeviceCycle:stop()
    streamDeck = nil
  end
end

function handleAppEvent(element, event, watcher, userData)
  if (event == "AXTitleChanged") then
    if string.find(element:title(), "Zoom Meeting ID") then
      if (hs.settings.get("in_meeting") == nil) then
        hs.settings.set("in_meeting", "yes")
      end
      -- do the thing
    end
  end
end

function zoomCallback(appName, eventType, appObject)
  if (appName == "zoom.us") then
    local events = hs.uielement.watcher
    local watcher = appObject:newWatcher(handleAppEvent)
    print("fart2" .. appName .. eventType)
    watcher:start({events.titleChanged})
  end
end

on_image       = streamDeckImage("on.png")
off_image      = streamDeckImage("off.png")
iterm_image    = streamDeckImage("iterm.png")
mute_off_image = streamDeckImage("mute_off.png")
mute_on_image  = streamDeckImage("mute_on.png")
issue_image    = streamDeckImage("issue.png")
mr_image       = streamDeckImage("merge_request.png")
record_image   = streamDeckImage("zoom_active.gif")

tweetbot  = hs.application"Tweetbot"
slack     = hs.application"Slack"
reeder    = hs.application"Reeder"
firefox   = hs.application"Firefox"
zoom      = hs.application"zoom.us"
spotify   = hs.application"Spotify"
alacritty = hs.application"Alacritty"



hs.streamdeck.init(streamDeckDiscovery)
hs.timer.doAt("23:59", "1d", streamDeckDiscovery)
hs.timer.doAt("08:00", "1d", streamDeckDiscovery)
zoomWatcher = hs.application.watcher.new(zoomCallback)
zoomWatcher:start()
