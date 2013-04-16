local cachedWifi      = hs.wifi.currentNetwork()
local cachedPower     = hs.battery.powerSource()

function custom_read_from(file)
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function update_gitlab()
  hs.execute(system_ruby .. " /Users/gary/.zsh/bin/glupdate")
end

hs.timer.doEvery(3600, update_gitlab)
update_gitlab()

function custom_max_key(t)
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
  if readLocationData() == nil then
    return ""
  else
    return custom_max_key(hs.json.decode(readLocationData()))
  end
end

function readLocationData()
  location_data = custom_read_from(os.getenv("HOME") .. "/iCloud/Internal/whereami.data")
  return location_data[1]
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
  ollies_room             = "home_wifi",
}

function caffeineChanged(watcher)
  print("watcher: " .. watcher)

  if watcher == hs.caffeinate.watcher.systemWillSleep then
    deck = hs.streamdeck.getDevice(1)
    if deck then
      deck:reset()
      deck:setBrightness(0)
    end
  end

  if watcher == hs.caffeinate.watcher.screensDidUnlock then
    print("screen unlock")
    if deck then
      print("updating stream deck")
      initialScreen(deck)
    end
  end

  if watcher == hs.caffeinate.watcher.systemDidWake then
    getLocation()
  end
end

function powerChanged()
  print("power source: " .. hs.battery.powerSource())
  print("charge left: " .. hs.battery.capacity())
  print("percentage: " .. hs.battery.percentage())
  print("the rest:" .. hs.inspect(hs.battery.getAll()))
  local powerSource = hs.battery.powerSource()
  if powerSource ~= cachedPower then
    cachedPower = powerSource
    getLocation()
  end
end

function qualityChanged(watcher, message, interface, rssi, rate)
  print("Link quality rssi: " .. rssi)
  print("Link quality rate: " .. rate)
end

function wifiChanged(watcher, message)
  if message == "BSSIDChange" then
    hs.alert("we changed bssids! was this right? check your hammerspoon")
    getLocation()
  end

  wifiName  = hs.wifi.currentNetwork()
  security  = hs.wifi.interfaceDetails().security

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
  if (hs.settings.get("scenario") == nil or hs.settings.get("scenario") ~= id) and id ~= nil then
    print("setting scenario:" .. id)
    hs.settings.set("scenario", id)
    rubyRunner(id, "")
  end
end

function usbDevices()
  devices = hs.usb.attachedDevices()
  print(hs.inspect(devices))
end

-- powerWatcher    = hs.battery.watcher.new(powerChanged):start()
caffeineWatcher = hs.caffeinate.watcher.new(caffeineChanged):start()
wifiWatcher     = hs.wifi.watcher.new(wifiChanged):watchingFor({
    "BSSIDChange", "SSIDChange",
  }):start()

getLocation()
