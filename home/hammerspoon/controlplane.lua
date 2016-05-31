local wifiWatcher  = nil
local powerWatcher = nil
local homeSSID     = "dandg"
local homeSSIDfive = "dandg_5G"
local nuSSID       = "Northwestern"
local ruby         = "/usr/local/opt/rbenv/shims/ruby"
-- local controlplane = hs.menubar.new()

local hyper = {"⌘", "⌥", "⌃", "⇧"}
hs.hotkey.bind(hyper, '0', function()
  print(wifiWatcher)
  print(powerWatcher)
  print(hearthWatcher)
end)

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
  -- print("checking for " .. id)
  if hs.settings.get("scenario") ~= id then
    -- print("setting  " .. id)
    hs.settings.set("scenario", id)
    -- controlplaneDisplay(titlebar)
    rubyRunner(runner)
    if wifiStatus == true then
      wifiOn()
    else
      wifiOff()
    end
    -- print("checking for keyboard")
    -- if id == "home_desk" then
    --   print("setting keyboard!")
    --   os.execute('/Applications/Karabiner.app/Contents/Library/bin/karabiner select_by_name Bluetooth')
    -- else
    --   os.execute('/Applications/Karabiner.app/Contents/Library/bin/karabiner select_by_name Default')
    -- end
  end
end

function powerChangedCallback()
  local powerSource = hs.battery.powerSource()
  local powerSerial = hs.battery.psuSerial()
  if powerSource == "AC Power" then -- if we're on power
    -- hs.alert("power")
    -- print("setting power mode")
    -- print(powerSerial)
    if powerSerial == 6857791 then
      -- print("we're at nubic desk")
      nubic()
      elseif powerSerial == 8600800 then
        -- print("we're at nu desk")
        nuDesk()
        elseif powerSerial == 1255676 then
          -- hs.alert("desk")
          -- print("we're at home desk")
          homeDesk()
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
            -- hs.alert("wifi")
            ssidChangedCallback()
          end
        end

        -- function controlplaneDisplay(state)
        --   controlplane:setTitle(state)
        -- end

        function controlplaneClicked()
          hs.settings.set("scenario", "nil")
          hs.reload()
        end

        function ssidChangedCallback()
          local currentSSID = hs.wifi.currentNetwork()
          if currentSSID == homeSSID or currentSSID == homeSSIDfive then
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
            setScenario("nu_roaming","🏥📶", "nu_desk", true)
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
