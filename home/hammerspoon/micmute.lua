--- This is a fork by Gary Holtz. The original version information is below:
--- === MicMute ===
---
--- Microphone Mute Toggle and status indicator
---
--- Download: [https://github.com/dctucker/Spoons/raw/master/Spoons/MicMute.spoon.zip](https://github.com/dctucker/Spoons/raw/master/Spoons/MicMute.spoon.zip)

local obj={}
__index = obj

-- Metadata
obj.name = "MicMute"
obj.version = "1.0"
obj.author = "dctucker <dctucker@github.com>"
obj.homepage = "https://dctucker.com"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function updateMicMute(muted)
  if muted == -1 then
    muted = hs.audiodevice.defaultInputDevice():muted()
  end
  if muted then
    mute_menu:setTitle("📵 Muted")
  else
    mute_menu:setTitle("")
  end
end

chrome = hs.application'Chrome'
--- MicMute:toggleMicMute()
--- Method
--- Toggle mic mute on/off
---
function toggleMicMute()
  local mic = hs.audiodevice.defaultInputDevice()
  local zoom = hs.application'Zoom'
  if mic:muted() then
    mic:setMuted(false)
    if zoom then
      local ok = zoom:selectMenuItem'Unmute Audio'
      if not ok then
        hs.timer.doAfter(0.5, function()
          zoom:selectMenuItem'Unmute Audio'
        end)
      end
    elseif chrome and string.match(chrome:mainWindow():title(), "Meet - ") then
      muteMeet()
    end
  else
    mic:setMuted(true)
    if zoom then
      local ok = zoom:selectMenuItem'Mute Audio'
      if not ok then
        hs.timer.doAfter(0.5, function()
          zoom:selectMenuItem'Mute Audio'
        end)
      end
    elseif chrome and string.match(chrome:mainWindow():title(), "Meet - ") then
      muteMeet()
    end

  end
  updateMicMute(-1)
end

function muteMeet()
  hs.osascript.applescriptFromFile("/Users/gary/code/dotfiles/home/hammerspoon/MuteMeet.scpt")
end

time_since_mute = 0
mute_menu = hs.menubar.new()
mute_menu:setClickCallback(function()
  toggleMicMute()
end)
updateMicMute(-1)

hs.audiodevice.watcher.setCallback(function(arg)
  if string.find(arg, "dIn ") then
    updateMicMute(-1)
  end
end)
hs.audiodevice.watcher.start()
