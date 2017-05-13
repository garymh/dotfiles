local whereami    = sh.command('/usr/local/bin/whereami', 'predict')
local cachedWifi  = hs.wifi.currentNetwork()
local cachedPower = hs.battery.powerSource()

local usbWatcher      = nil
local wifiWatcher     = nil
local powerWatcher    = nil
local caffeineWatcher = nil

function getLocation()
  return tostring(whereami())
end

function rubyRunner(name, argument)
  print(" running:/usr/bin/env ruby ~/.hammerspoon/controlplane_actions/" .. name .. ".rb " .. argument)
  os.execute("/usr/bin/env ruby ~/.hammerspoon/controlplane_actions/" .. name .. ".rb " .. argument)
end

scenarios = {
  living_room_left_couch = "home_wifi",
  back_kitchen_table     = "home_wifi",
  bed                    = "home_wifi",
  home_desk              = "home_desk",
  nubic_conf_room        = "nubic"
}

function caffeineCheckForChange(data)
  print("Running caffeine check for change")
  if data == hs.caffeinate.watcher.systemDidWake then
    time = os.date("*t")
    print("LOG caffeine: " .. time.hour .. ":" .. time.min .. ":" .. time.sec)
    checkForChange()
  end
end

function powerCheckForChange()
  print("Running power check for change")
  local powerSource = hs.battery.powerSource()
  if powerSource ~= cachedPower then
    time = os.date("*t")
    print("LOG power: " .. time.hour .. ":" .. time.min .. ":" .. time.sec)
    cachedPower = powerSource
    checkForChange()
  end
end

function wifiCheckForChange(data)
  print("Running wifi check for change")
  print("wifi event: " .. hs.inspect(data))
  currentSSID = hs.wifi.currentNetwork()
  if currentSSID ~= cachedWifi then
    time = os.date("*t")
    print("LOG wifi: " .. time.hour .. ":" .. time.min .. ":" .. time.sec)
    checkForChange()
    cachedWifi = currentSSID
  end
end

function checkForChange()
  location = getLocation()
  print("we think we're at: " .. location)
  if location ~= nil then
    setScenario(scenarios[location])
  else
    hs.alert("Unknown location! Please set")
    setScenario('road')
  end
end

function setScenario(id)
  if hs.settings.get("scenario") ~= id then
    print("setting scenario:" .. id)
    hs.settings.set("scenario", id)
    rubyRunner(id, "")
  end
end

function usbDevices()
  devices = hs.usb.attachedDevices()
  print(hs.inspect(devices))
end

function deviceToggle(data, addedFunction, removedFunction)
  if (data["eventType"] == "added") then
    print("Added: " .. data["productName"])
    addedFunction()
  elseif (data["eventType"] == "removed") then
    print("Removed: " .. data["productName"])
    removedFunction()
  end
end

function usbDeviceCallback(data)
  print("Device: " .. data["productName"])
  if (data["productName"] == "BLUE NESSIE USB MIC") then
    deviceToggle(
      data,
      function() setScenario("recording") end,
      function() checkForChange() end
    )
  elseif (data["productName"] == "D4269") then
    deviceToggle(
      data,
      function() rubyRunner("switch_keyboard", "desk") end,
      function() rubyRunner("switch_keyboard", "laptop") end
    )
  -- elseif (data["productName"] == "C-Media USB Audio Device   ") then
  --   deviceToggle(
  --     data,
  --     function() rubyRunner("headphones", "") end,
  --     function() rubyRunner("desk_audio", "") end
  --   )
  elseif (data["productName"] == "Display Audio") then
    deviceToggle(
      data,
      function() rubyRunner("desk_audio", "") end,
      function() end
    )
  end
end

powerWatcher = hs.battery.watcher.new(powerCheckForChange)
wifiWatcher = hs.wifi.watcher.new(wifiCheckForChange)
caffeineWatcher = hs.caffeinate.watcher.new(caffeineCheckForChange)
usbWatcher = hs.usb.watcher.new(usbDeviceCallback)

powerWatcher:start()
wifiWatcher:start()
usbWatcher:start()
caffeineWatcher:start()
