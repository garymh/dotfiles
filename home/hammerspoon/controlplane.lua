local wifiWatcher  = nil
local powerWatcher = nil
local homeSSID     = "dandg"
local homeSSIDfive = "dandg5"
local homeSSIDbr5  = "dandgb5"
local nuSSID       = "Northwestern"
local ruby         = "/usr/local/opt/rbenv/shims/ruby"
local controlplane = hs.menubar.new()

function wifiOff()
  if wifiWatcher then
    wifiWatcher:stop()
  end
  wifiWatcher = nil
end

function wifiOn()
  wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
  wifiWatcher:start()
end

function rubyRunner(name)
  os.execute(ruby .. " ~/.hammerspoon/controlplane/" .. name .. ".rb")
end

function setScenario(id, titlebar, runner, wifiStatus)
  if hs.settings.get("scenario") ~= id then 
    hs.settings.set("scenario", id)
    controlplaneDisplay(titlebar)
    rubyRunner(runner)  
    if wifiStatus == true then
      wifiOn()
    else
      wifiOff()
    end
  end
end

function powerChangedCallback()
  local powerSource = hs.battery.powerSource()
  local powerSerial = hs.battery.psuSerial()
  if powerSource == "AC Power" then -- if we're on power
    if powerSerial == 6857791 then
      nubic()
    elseif powerSerial == 8600800 then
      nuDesk()
    elseif powerSerial == 1255676 then
      homeDesk()
    elseif powerSerial == 6771448 then -- portable
      ssidChangedCallback()
    elseif powerSerial == 4886968 then -- portable
      ssidChangedCallback()
    else
      road()
    end
  else
    ssidChangedCallback()
  end
end

function controlplaneDisplay(state)
  controlplane:setTitle(state)
end

function controlplaneClicked()
  hs.settings.set("scenario", "nil")
  hs.reload()
end

function ssidChangedCallback()
  local currentSSID = hs.wifi.currentNetwork()
  if currentSSID == homeSSID or currentSSID == homeSSIDfive or currentSSID == homeSSIDbr5 then
    homeWifi()
  elseif currentSSID == nuSSID then
    nuRoaming()
  else
    road()
  end
end

function homeWifi()
  setScenario("home_wifi","🏠📶", "home", true) 
end

function homeDesk()
  setScenario("home_desk","🏠💻", "desk", false) 
end

function nuRoaming()
  setScenario("nu_roaming","🏥📶", "desk", true) 
end

function nuDesk()
  setScenario("nu_desk","🏥💻", "nu_desk", false) 
end

function road()
  setScenario("road","☕", "road", true) 
end

function nubic()
  setScenario("nubic","NUBIC", "nubic", false) 
end

if controlplane then
  controlplane:setClickCallback(controlplaneClicked)
end

powerWatcher = hs.battery.watcher.new(powerChangedCallback)
powerWatcher:start()
wifiWatcher  = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

if power == nil then
  powerChangedCallback()
end
