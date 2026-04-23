local debounceTimer = nil

local function setAudiosourceBarTitle(_)
  if debounceTimer then debounceTimer:stop() end
  debounceTimer = hs.timer.doAfter(1.5, function()
    hs.shortcuts.run("Set Correct Soundsource Preset")
    debounceTimer = nil
  end)
end

local audioWatcher = hs.audiodevice.watcher
audioWatcher.setCallback(setAudiosourceBarTitle)
audioWatcher.start()
