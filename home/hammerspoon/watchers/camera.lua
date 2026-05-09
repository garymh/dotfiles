local cameraFocus = {
  cameraName = "Cam Phone Camera",
  focusEnabledByUs = false,
}

local function findCamera()
  for _, cam in ipairs(hs.camera.allCameras()) do
    if cam:name() == cameraFocus.cameraName then
      return cam
    end
  end
  return nil
end

local function handleCameraState(inUse)
  if inUse and not cameraFocus.focusEnabledByUs then
    hs.shortcuts.run("AUTO: Turn on Meeting focus")
    cameraFocus.focusEnabledByUs = true
  elseif not inUse and cameraFocus.focusEnabledByUs then
    hs.shortcuts.run("AUTO: Turn off Meeting focus")
    cameraFocus.focusEnabledByUs = false
  end
end

local webcam = findCamera()
if webcam then
  webcam:setPropertyWatcherCallback(function(camera, property, scope, element)
    if property == "gone" then return end
    handleCameraState(camera:isInUse())
  end)
  webcam:startPropertyWatcher()

  if webcam:isInUse() then
    handleCameraState(true)
  end
end
