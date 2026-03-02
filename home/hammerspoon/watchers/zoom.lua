local zoomWallpaper = {
  enabled = true,
  zoomPath = "/Users/gary/Documents/Wallpapers/Citrus Peel.jpg",
  previousWallpaper = nil,
  isZoomActive = false,
}

local function getWallpaper()
  local output, status = hs.execute("/opt/homebrew/bin/wallpaper get", false)
  if status then
    return output:gsub("%s+$", "")
  end
  return nil
end

local function setWallpaper(path)
  for i, scr in ipairs(hs.screen.allScreens()) do
    if scr then
      print(hs.inspect(scr))
      print(path)
    end
    scr:desktopImageURL(path)
  end
end

local function handleZoomWallpaper(isActive)
  if isActive and not zoomWallpaper.isZoomActive then
    zoomWallpaper.previousWallpaper = getWallpaper()
    setWallpaper(zoomWallpaper.zoomPath)
    zoomWallpaper.isZoomActive = true
  elseif not isActive and zoomWallpaper.isZoomActive then
    if zoomWallpaper.previousWallpaper then
      setWallpaper(zoomWallpaper.previousWallpaper)
    end
    zoomWallpaper.isZoomActive = false
  end
end

ZoomAppWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
  if appName == "zoom.us" then
    if eventType == hs.application.watcher.launched then
      handleZoomWallpaper(true)
    elseif eventType == hs.application.watcher.terminated then
      handleZoomWallpaper(false)
    end
  end
end)
ZoomAppWatcher:start()

if hs.application.get("zoom.us") then
  handleZoomWallpaper(true)
end
