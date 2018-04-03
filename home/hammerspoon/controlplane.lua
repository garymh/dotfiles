-- local whereami    = sh.command('/usr/local/bin/whereami', 'predict')
local cachedWifi      = hs.wifi.currentNetwork()
local cachedPower     = hs.battery.powerSource()
local cachedEvent     = nil

-- local usbWatcher      = nil
-- local wifiWatcher     = nil
-- local powerWatcher    = nil
-- local caffeineWatcher = nil

function readFrom(file)
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function max_key(t)
  max_k, max_v = nil, 0
  for index,value in pairs(t) do
    if value > max_v then
      max_k, max_v = index, value
    end
  end
  return max_k
end

function predictLocation()
  hs.execute("/usr/local/bin/whereami predict_proba > ~/iCloud/Internal/whereami.data")
  return readLocation()
end

function readLocation()
  return max_key(json.decode(readLocationData()))
end

function readLocationData()
  table = readFrom(os.getenv("HOME") .. "/iCloud/Internal/whereami.data")
  return table[1]
end

function rubyRunner(name, argument)
  print(" running:/usr/bin/env ruby ~/.hammerspoon/controlplane_actions/" .. name .. ".rb " .. argument)
  os.execute("/usr/bin/env ruby ~/.hammerspoon/controlplane_actions/" .. name .. ".rb " .. argument)
end

local secureNetworks = {
  'WPA Personal Mixed',
  'WPA2 Personal',
  'WPA Enterprise Mixed',
}

local whiteList = {
  'dandg'
}

scenarios = {
  kitchen_table           = "home_wifi",
  dining_room_table       = "home_wifi",
  dining_room_table_front = "home_wifi",
  bed                     = "home_wifi",
  home_desk               = "home_desk",
  kitchen_table           = "home_wifi",
  living_room_couch_r     = "home_wifi",
  nu_desk                 = "work",
  nubic_conf_room         = "nubic",
  ollies_room             = "home_wifi",
  renee_office            = "work"
}

function caffeineChanged(watcher)
  -- print("caffeineChanged: " .. hs.inspect(watcher))
  -- print("=======================================================")
  -- print("caffeineChanged: " .. watcher)
  -- print("-------------------------------------------------------")
  -- print("caffeine screensaverDidStart: " .. hs.caffeinate.watcher.screensaverDidStart)
  -- print("caffeine screensaverDidStop: " .. hs.caffeinate.watcher.screensaverDidStop)
  -- print("caffeine screensaverWillStop: " .. hs.caffeinate.watcher.screensaverWillStop)
  -- print("caffeine screensDidLock: " .. hs.caffeinate.watcher.screensDidLock)
  -- print("caffeine screensDidSleep: " .. hs.caffeinate.watcher.screensDidSleep)
  -- print("caffeine screensDidUnlock: " .. hs.caffeinate.watcher.screensDidUnlock)
  -- print("caffeine screensDidWake: " .. hs.caffeinate.watcher.screensDidWake)
  -- print("caffeine sessionDidBecomeActive: " .. hs.caffeinate.watcher.sessionDidBecomeActive)
  -- print("caffeine sessionDidResignActive: " .. hs.caffeinate.watcher.sessionDidResignActive)
  -- print("caffeine systemDidWake: " .. hs.caffeinate.watcher.systemDidWake)
  -- print("caffeine systemWillPowerOff: " .. hs.caffeinate.watcher.systemWillPowerOff)
  -- print("caffeine systemWillSleep: " .. hs.caffeinate.watcher.systemWillSleep)
  -- print("=======================================================")

  cachedEvent = watcher
  if watcher == hs.caffeinate.watcher.systemDidWake then
    getLocation()
  end
end

function powerChanged()
  -- print("power source: " .. hs.battery.powerSource())
  -- print("charge left: " .. hs.battery.capacity())
  -- print("percentage: " .. hs.battery.percentage())
  -- print("the rest:" .. hs.inspect(hs.battery.getAll()))
  local powerSource = hs.battery.powerSource()
  if powerSource ~= cachedPower then
    cachedPower = powerSource
    print("power changed")
    getLocation()
  end
end

-- function wifiCheckForChange(data)
--   print("wifiCheckForChange()")
--   print("wifi event: " .. hs.inspect(data))
--   currentSSID = hs.wifi.currentNetwork()
--   if currentSSID ~= cachedWifi then
--     time = os.date("*t")
--     print("LOG wifi: " .. time.hour .. ":" .. time.min .. ":" .. time.sec)
--     checkForChange()
--     cachedWifi = currentSSID
--   end
-- end

function qualityChanged(watcher, message, interface, rssi, rate)
  -- print("Link quality change1" .. watcher)
  -- print("Link quality change2" .. message)
  -- print("Link quality change3" .. interface)
  print("Link quality rssi: " .. rssi)
  print("Link quality rate: " .. rate)
end

function wifiChanged(watcher, message)
  print("HELLO I AM WIFI CHANGE " .. message)

  if message == "BSSIDChange" then
    print("we changed bssids!")
    getLocation()
  end

  wifiName  = hs.wifi.currentNetwork()
  security  = hs.wifi.interfaceDetails().security
  -- interface = hs.wifi.interfaceDetails()

  local wifiName = hs.wifi.currentNetwork()
  local security = hs.wifi.interfaceDetails().security

  if not wifiName or hs.fnutils.contains(secureNetworks, security) and hs.fnutils.contains(whiteList, wifiName) then
    if wifiMenu then
      wifiMenu:removeFromMenuBar()
    end
  else
    if not wifiMenu then
      wifiMenu = hs.menubar.newWithPriority(2147483645)
    end

    wifiMenu:setTitle(wifiName)
    wifiMenu:setTooltip('This WiFi network is not recognized. Consider using a known one.')

    if not hs.fnutils.contains(secureNetworks, security) then
      wifiMenu:setTitle('Insecure: ' .. wifiName)
      wifiMenu:setTooltip('This WiFi network is insecure. Consider using a secure one.')
    end

  end
end

function getLocation()
  location = predictLocation()
  print("we think we're at: " .. location)
  if location ~= nil then
    setScenario(scenarios[location])
  else
    hs.alert("Unknown location! Please set")
    setScenario('road')
  end
end

function setScenario(id)
  if hs.settings.get("scenario") == nil or hs.settings.get("scenario") ~= id then
    print("setting scenario:" .. id)
    hs.settings.set("scenario", id)
    rubyRunner(id, "")
  end
end

function usbDevices()
  devices = hs.usb.attachedDevices()
  print(hs.inspect(devices))
end

-- function deviceToggle(data, addedFunction, removedFunction)
--   if (data["eventType"] == "added") then
--     print("Added: " .. data["productName"])
--     addedFunction()
--   elseif (data["eventType"] == "removed") then
--     print("Removed: " .. data["productName"])
--     removedFunction()
--   end
-- end

-- function usbDeviceCallback(data)
--   print("Device: " .. data["productName"])
--   if (data["productName"] == "BLUE NESSIE USB MIC") then
--     deviceToggle(
--       data,
--       function() setScenario("recording") end,
--       function() checkForChange() end
--     )
--   elseif (data["productName"] == "D4269" or data["productName"] == "daskeyboard") then
--     deviceToggle(
--       data,
--       function() rubyRunner("switch_keyboard", "desk") end,
--       function() rubyRunner("switch_keyboard", "laptop") end
--     )
--   -- elseif (data["productName"] == "C-Media USB Audio Device   ") then
--   --   deviceToggle(
--   --     data,
--   --     function() rubyRunner("headphones", "") end,
--   --     function() rubyRunner("desk_audio", "") end
--   --   )
--   elseif (data["productName"] == "Display Audio") then
--     deviceToggle(
--       data,
--       function() rubyRunner("desk_audio", "") end,
--       function() end
--     )
--   end
-- end

-- wifiWatcher     = hs.wifi.watcher.new(wifiCheckForChange):start()
-- usbWatcher      = hs.usb.watcher.new(usbDeviceCallback)
-- usbWatcher:start()

function hasExternalMonitor()
  for _, screen in pairs(hs.screen.allScreens()) do
    if screen:name() == "Thunderbolt Display" then
      return true
    end
  end
  return false
end

-- Switch dynamic profile in iTerm2
function setIterm2Profile(filename)
  hs.execute("ln -sf $HOME/code/dotfiles/iterm/" .. filename .. " \"$HOME/Library/Application Support/iTerm2/DynamicProfiles/iTerm2_Dynamic.json\"")
end

function monitorChanged()
  if hasExternalMonitor() then
    setIterm2Profile("iTerm2_dynamic_big.json")
  else
    setIterm2Profile("iTerm2_dynamic_small.json")
  end
end

local powerWatcher    = hs.battery.watcher.new(powerChanged):start()
local caffeineWatcher = hs.caffeinate.watcher.new(caffeineChanged):start()
local wifiWatcher     = hs.wifi.watcher.new(wifiChanged):watchingFor({
    "BSSIDChange", "SSIDChange",
  }):start()
-- local qualityWatcher     = hs.wifi.watcher.new(qualityChanged):watchingFor({
--     "linkQualityChange",
--   }):start()
local monitorWatcher  = hs.screen.watcher.new(monitorChanged):start()

getLocation()
