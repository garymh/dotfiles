local log = hs.logger.new("camera", "info")

local cameraState = {
  cameraName = "Cam Phone Camera",
  activeByUs = false,
  propertyWatcher = nil,
  -- wallpaper
  meetingWallpaper = "/Users/gary/Documents/Wallpapers/Citrus Peel.jpg",
  previousWallpaper = nil,
}

local function getWallpaper()
  local output, status = hs.execute("/opt/homebrew/bin/wallpaper get", false)
  if status then
    return output:match("([^\n]+)")
  end
  return nil
end

local function setWallpaper(path)
  local plain = path:gsub("^file://", "")
  local encoded = plain:gsub(" ", "%%20")
  local url = "file://" .. encoded
  for _, scr in ipairs(hs.screen.allScreens()) do
    scr:desktopImageURL(url)
  end
end

local function handleCameraState(inUse)
  if inUse and not cameraState.activeByUs then
    log.i("Camera in use — enabling Meeting focus + wallpaper")
    hs.shortcuts.run("AUTO: Turn on Meeting focus")
    cameraState.previousWallpaper = getWallpaper()
    setWallpaper(cameraState.meetingWallpaper)
    cameraState.activeByUs = true
  elseif not inUse and cameraState.activeByUs then
    log.i("Camera no longer in use — disabling Meeting focus + wallpaper")
    hs.shortcuts.run("AUTO: Turn off Meeting focus")
    if cameraState.previousWallpaper then
      setWallpaper(cameraState.previousWallpaper)
    end
    cameraState.activeByUs = false
  end
end

local function attachToCamera(cam)
  if cameraState.propertyWatcher then
    log.d("Already watching a camera, skipping")
    return
  end

  log.i("Attaching property watcher to: " .. cam:name())
  cam:setPropertyWatcherCallback(function(camera, property, scope, element)
    log.d("Property event: " .. tostring(property))
    handleCameraState(camera:isInUse())
  end)
  cam:startPropertyWatcher()
  cameraState.propertyWatcher = cam

  if cam:isInUse() then
    handleCameraState(true)
  end
end

local function findAndAttach()
  for _, cam in ipairs(hs.camera.allCameras()) do
    if cam:name() == cameraState.cameraName then
      attachToCamera(cam)
      return
    end
  end
  log.d("Camera not found: " .. cameraState.cameraName)
end

-- Watch for cameras being added/removed so we catch late-connecting devices
-- (e.g. Continuity Camera, USB webcams plugged in after boot)
hs.camera.setWatcherCallback(function(camera, change)
  log.i("Camera " .. change .. ": " .. camera:name())
  if change == "Added" and camera:name() == cameraState.cameraName then
    attachToCamera(camera)
  elseif change == "Removed" and cameraState.propertyWatcher then
    log.i("Watched camera removed — clearing watcher")
    cameraState.propertyWatcher = nil
    if cameraState.activeByUs then
      handleCameraState(false)
    end
  end
end)
hs.camera.startWatcher()

-- Try to attach now in case the camera is already connected
findAndAttach()
