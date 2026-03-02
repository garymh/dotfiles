local function setAudiosourceBarTitle(_)
  hs.shortcuts.run("Set Correct Soundsource Preset")
end

local audioWatcher = hs.audiodevice.watcher
audioWatcher.setCallback(setAudiosourceBarTitle)
audioWatcher.start()
