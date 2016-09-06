local wifiWatcher  = nil
local powerWatcher = nil
local homeSSID     = "dandg"
local homeSSIDfive = "dandg_5G"
local nuSSID       = "Northwestern"
local ruby         = "/usr/local/opt/rbenv/shims/ruby"

function rubyRunner(name)
  os.execute(ruby .. " ~/.hammerspoon/controlplane/" .. name .. ".rb")
end

-- function set_vpn(value)
--   print("checking for " .. value)
--   if hs.settings.get("vpn") ~= value then
--     print("setting  " .. value)
--     hs.settings.set("vpn", value)
--     if value == "on" then
--       rubyRunner("vpn")
--     else
--       rubyRunner("no_vpn")
--     end
--   end
-- end

function setScenario(id)
  print("checking for " .. id)
  if hs.settings.get("scenario") ~= id then
    print("setting  " .. id)
    hs.settings.set("scenario", id)
    rubyRunner(id)
  end
end

function powerChangedCallback()
  local powerSource = hs.battery.powerSource()
  local powerSerial = hs.battery.psuSerial()
  if powerSource == "AC Power" then -- if we're on power
    print("setting power mode")
    print("power serial: " .. powerSerial)

    if powerSerial     == 6857791 then
      setScenario("nu_desk")
    elseif powerSerial == 8600800 then
      setScenario("nubic")
    elseif powerSerial == 1255676 then
      setScenario("home_desk")
    elseif powerSerial == 6771448 then -- portable
      ssidChangedCallback()
    elseif powerSerial == 4886968 then -- portable
      ssidChangedCallback()
    elseif powerSerial == 1678943 then -- portable
      ssidChangedCallback()
    else
      road()
    end
  else
    ssidChangedCallback()
  end
end

function ssidChangedCallback()
  local currentSSID = hs.wifi.currentNetwork()

  if currentSSID == homeSSID or currentSSID == homeSSIDfive then
    setScenario("home_wifi")
  elseif currentSSID == nuSSID then
    setScenario("nu_wifi")
  else
    setScenario("road")
  end
end

-- hs.network.reachability.internet():setCallback(function(self)
--   if (hs.network.reachability.flags.reachable) > 0 then
--     -- vpn?
--     local as = [[
--     tell application "System Events"
--     tell current location of network preferences
--     set VPNservice to service "NU VPN"
--     set isConnected to connected of current configuration of VPNservice
--     if isConnected then
--       "on"
--     else
--       "off"
--     end if
--   end tell
-- end tell
-- ]]
-- local status, object, descriptor = hs.osascript.applescript(as)
-- -- print("config:" .. object)
-- if object == "on" then
--   set_vpn("on")
-- else
--
--   set_vpn("off")
-- end
--   else
--     -- no internet
--   end
-- end):start()

powerWatcher = hs.battery.watcher.new(powerChangedCallback)
powerWatcher:start()
wifiWatcher  = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

if power == nil then
  powerChangedCallback()
end
