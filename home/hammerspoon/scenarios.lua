local secureNetworks = {
  "WPA Personal Mixed",
  "WPA2 Personal",
  "WPA Enterprise Mixed",
}
local whiteList = { "dandg", "dvorak" }

-- 0 didWake
-- 1 hs.caffeinate.watcher.systemWillSleep
-- 2 hs.caffeinate.watcher.systemWillPowerOff
-- 3 hs.caffeinate.watcher.screensDidSleep
-- 4 hs.caffeinate.watcher.screensDidWake
-- 5 hs.caffeinate.watcher.sessionDidResignActive
-- 6 hs.caffeinate.watcher.sessionDidBecomeActive
-- 7 hs.caffeinate.watcher.screensaverDidStart
-- 8 hs.caffeinate.watcher.screensaverWillStop
-- 9 hs.caffeinate.watcher.screensaverDidStop
-- 10 hs.caffeinate.watcher.screensDidLock
-- 11 hs.caffeinate.watcher.screensDidUnlock
--
-- 1 system will sleep
-- 3 screen did sleep
-- 10 screen did lock

-- 0  did wake
-- 4  screen did wake
-- 11 screen did unlock

function caffeineChanged(watcher)
  print("WATHCER: " .. watcher)
  -- if watcher == hs.caffeinate.watcher.systemWillSleep then
    -- deck = hs.streamdeck.getDevice(1)
    -- if deck then
    --   deck:reset()
    --   deck:setBrightness(0)
    -- end
  -- end
  -- if watcher == hs.caffeinate.watcher.screensDidUnlock then
    -- deck = hs.streamdeck.getDevice(1)
    -- if deck then
    --   initialScreen(deck)
    -- end
  -- end

  if watcher == hs.caffeinate.watcher.screensDidUnlock then
    hs.timer.doAfter(3.5, function()
      hs.alert("quietly reloading")
      quietReload()
    end)
    -- deck = hs.streamdeck.getDevice(1)
    -- if deck then
    --   initialScreen(deck)
    -- end
  end
end

function screenChanged(watcher)

  print("OI")
  print(hs.inspect(watcher))

  screens         = hs.screen.allScreens()
  monitors        = tablelength(screens)
  print("monitor size " .. monitors)

  if hs.settings.get("screens") == nil then
    print("no monitor value. setting")
    hs.settings.set("screens", monitors)
  elseif hs.settings.get("screens") == monitors then
    print("not reloading")
    return
  else
    hs.settings.set("screens", monitors)
    print("reloading")
    hs.timer.doAfter(3.5, function()
      quietReload()
    end)
  end

  -- if watcher == hs.caffeinate.watcher.screensDidUnlock then
  --   print("butt")
  --   hs.timer.doAfter(3.5, function() hs.reload() end)
  -- end
end

function qualityChanged(watcher, message, interface, rssi, rate)
  hs.alert("link quality changed (see console)")
  print("Link quality rssi: " .. rssi)
  print("Link quality rate: " .. rate)
end

function wifiChanged(watcher, message)
  if message == "BSSIDChange" then
    hs.alert("we changed bssids! was this right? check your hammerspoon")
  end

  wifiName = hs.wifi.currentNetwork()
  security = hs.wifi.interfaceDetails().security

  local wifiName = hs.wifi.currentNetwork()
  local security = hs.wifi.interfaceDetails().security

  if
    not wifiName
    or hs.fnutils.contains(secureNetworks, security)
      and hs.fnutils.contains(whiteList, wifiName)
  then
    if wifiMenu then
      wifiMenu:removeFromMenuBar()
    end
  else
    if not wifiMenu then
      wifiMenu = hs.menubar.newWithPriority(2147483645)
    end

    wifiMenu:setTitle(wifiName)
    wifiMenu:setTooltip(
      "This WiFi network is not recognized. Consider using a known one."
    )

    if not hs.fnutils.contains(secureNetworks, security) then
      wifiMenu:setTitle("Insecure: " .. wifiName)
      wifiMenu:setTooltip(
        "This WiFi network is insecure. Consider using a secure one."
      )
    end
  end
end

-- local screenwatcher = hs.screen.watcher.new(function()
--   -- local screens         = hs.screen.allScreens()
--   -- local monitors        = tablelength(screens)
--   -- hs.settings.get("screens")
--
--   print("oi")
--   -- if screens_setting == nil then
--   --   hs.settings.set("screens", table)
--   --   return
--   -- elseif screens_setting == monitors then
--   --   return
--   -- else
--   --   hs.reload()
--   -- end
-- end)

caffeineWatcher = hs.caffeinate.watcher.new(caffeineChanged)
screenWatcher = hs.screen.watcher.new(screenChanged)
wifiWatcher = hs.wifi.watcher.new(wifiChanged):watchingFor({
  "SSIDChange",
  "BSSIDChange",
  "countryCodeChange",
  "linkChange",
  "modeChange",
  "powerChange",
  "scanCacheUpdated",
})
qualityWatcher = hs.wifi.watcher.new(qualityChanged):watchingFor({
  "linkQualityChange",
})

caffeineWatcher:start()
qualityWatcher:start()
wifiWatcher:start()
screenWatcher:start()
