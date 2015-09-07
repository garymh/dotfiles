local wifiWatcher  = nil
local powerWatcher = nil
local homeSSID     = "dandg"
local homeSSIDfive = "dandg5"
local nuSSID       = "Northwestern"
local power        = hs.settings.get("power")
local wifi         = hs.settings.get("wifi")
local controlplane = hs.menubar.new()
local ruby         = "/usr/local/opt/rbenv/shims/ruby"

function wifiOff()
  if setKey("wifi_power","off") == true then
    os.execute("networksetup -setairportpower en0 off")
    if wifiWatcher then
      wifiWatcher:stop()
    end
    wifiWatcher = nil
  end
end

function wifiOn()
  if setKey("wifi_power","on") == true then
    os.execute("networksetup -setairportpower en0 on")
    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()
  end
end

function rubyRunner(name)
  os.execute(ruby .. " ~/.hammerspoon/controlplane/" .. name .. ".rb")
end

function powerChangedCallback()
  local powerSource  = hs.battery.powerSource()
  local powerSerial  = hs.battery.psuSerial()

  if powerSource == "AC Power" then
    -- if powerSerial == 6857791 then
    --   wifiOff()
    --   nubic()
    if powerSerial == 8600800 then
      wifiOff()
      nuDesk()
    elseif powerSerial == 1255676 then
      wifiOff()
      homeDesk()
    elseif powerSerial == 6771448 then
      wifiOn()
      ssidChangedCallback()
    end
  else
    if setKey("power","battery") == true then
      wifiOn()
      ssidChangedCallback()
    end
  end
end

function controlplaneDisplay(state)
  controlplane:setTitle(state)
end

function controlplaneClicked()
  hs.settings.set("wifi", nil)
  hs.settings.set("wifi_power", nil)
  hs.settings.set("scenario", nil)
  hs.settings.set("power", nil)
  hs.reload()
end

if controlplane then
  controlplane:setClickCallback(controlplaneClicked)
end

function ssidChangedCallback()
  local currentSSID = hs.wifi.currentNetwork()

  if currentSSID == homeSSID or currentSSID == homeSSIDfive then
    homeWifi()
  elseif currentSSID ~= homeSSID then
    road()
  end
end

function homeWifi()
  if setKey("wifi","home") == true then
    controlplaneDisplay("🏠📶")
    rubyRunner("home")
  end
end

function homeWifi()
  if setKey("wifi","home") == true then
    controlplaneDisplay("🏠📶")
    rubyRunner("home")
  end
end

function homeDesk()
  if setKey("scenario","desk") == true then
    controlplaneDisplay("🏠💻")
    rubyRunner("desk")
  end
end

function nuDesk()
  if setKey("scenario","nu_desk") == true then
    controlplaneDisplay("🏥💻")
    rubyRunner("rhlccc")
  end
end

function road()
  if setKey("wifi","road") == true then
    controlplaneDisplay("☕")
    rubyRunner("road")
  end
end

-- function nubic()
--   if setKey("power","nubic") == true then
--   end
-- end

function setKey(key, type)
 if hs.settings.get(key) == type then -- if already this type
   return false
 else
   hs.settings.set(key, type)         -- otherwise, return true
   return true
 end
end

powerWatcher = hs.battery.watcher.new(powerChangedCallback)
powerWatcher:start()
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

if power == nil then
  powerChangedCallback()
end
