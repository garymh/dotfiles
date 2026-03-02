local cameras = hs.camera.allCameras()
local webcam = cameras[2]
if webcam then
  print(cameras[2])
  webcam:setPropertyWatcherCallback(function(camera, property, scope, element)
    print("Camera Property Event: " .. tostring(camera:name()) .. ": " .. tostring(property))
    if camera:isInUse() then
      print("Camera in use")
    else
      print("Camera not in use")
    end
  end)
  webcam:startPropertyWatcher()
end
