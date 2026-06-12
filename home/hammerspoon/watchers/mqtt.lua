local config = {}
config.mqtt_host = "homeassistant.local"
config.mqtt_user = "gary"
config.mqtt_pass = (hs.execute('security find-generic-password -a hammerspoon -s homeassistant -w 2>&1')):gsub("\n", "")
config.mqtt_port = "1883"
config.debug = false

config.idle_time = 180
config.idle_interval = 60

local function mqtt_publish(topic, message)
  if config.mqtt_host == "none" then
    error("mqtt_host is required")
    return
  end

  local command = "/opt/homebrew/bin/mosquitto_pub -r -h " .. config.mqtt_host

  if config.mqtt_user ~= "none" then
    command = command .. " -u " .. config.mqtt_user .. ' -P "' .. config.mqtt_pass .. '"'
  end

  if config.mqtt_port ~= "none" then command = command .. " -p " .. config.mqtt_port end

  command = command .. " -t " .. topic .. ' -m "' .. message .. '"'

  if config.debug then
    command = command .. " -d "
    print("Command: " .. command)
  end

  command = command .. " 2>&1"

  local rout, rstatus, rtype, rrc = hs.execute(command, false)
  if config.debug then
    print("rstatus: " .. tostring(rstatus))
    print("rtype: " .. rtype)
    print("rrc: " .. rrc)
    print("rout:\n" .. rout)
  end

  if rrc ~= 0 then
    error("error code " .. rrc .. " in system command: " .. command)
  elseif string.match(rout, "error") then
    error("error output: " .. rout .. " in system command: " .. command)
  end
end

local function dostuff(app, override)
  if override ~= nil then
    mqtt_publish("minimon", override)
  else
    if app:focusedWindow() then
      local title = app:focusedWindow():title()

      if app:name() == "Ghostty" then
        local termTitle = hs.fnutils.split(title, " ")

        if termTitle[1] == "vim" then
          mqtt_publish("minimon", "vim")
        elseif termTitle[1] == "irb" or (termTitle[1] == "rails" and termTitle[2] == "c") then
          mqtt_publish("minimon", "IRB")
        else
          mqtt_publish("minimon", "Terminal")
        end
      else
        mqtt_publish("minimon", app:name())
      end
    end
  end
end

local function uiCallback(_element, event, watcher, app)
  if app:focusedWindow() then
    if not app:focusedWindow():isStandard() then return end
    if not app:focusedWindow():isVisible() then return end
  else
    return
  end

  if event == hs.uielement.watcher.titleChanged then
    dostuff(app)
  elseif event == hs.uielement.watcher.applicationDeactivated then
    watcher:stop()
  end
end

local isDocked = require("utils").isDocked

local function ApplicationWatcher(appName, eventType, appObject)
  if eventType == hs.application.watcher.activated then
    if appName == "Mail" then
      local applescript = [[
            use AppleScript version "2.4"
            use scripting additions
            use framework "Foundation"
            use framework "ScriptingBridge"

            tell application "Mail"
            tell mailbox "Junk" of account "iCloud"
            set read status of messages whose read status is false to true
            end tell
            end tell
          ]]

      hs.osascript.applescript(applescript)
    end

    if isDocked() == false then return end

    if appName == "Firefox Developer Edition" then
      dostuff(appObject, "Work")
    elseif appName == "Neovide" then
      dostuff(appObject)
    elseif appName == "Ghostty" then
      dostuff(appObject)

      Watcher = appObject:newWatcher(uiCallback, appObject)

      Watcher:start({
        hs.uielement.watcher.titleChanged,
        hs.uielement.watcher.applicationDeactivated,
      })
    else
      dostuff(appObject)
    end
  end
end

AppWatcher = hs.application.watcher.new(ApplicationWatcher)
AppWatcher:start()
