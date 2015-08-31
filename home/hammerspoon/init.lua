local hyper = {"cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

require "moom"
-- require "calendar"
require "omnifocus"
require "controlplane"

-- reloader
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    -- hs.settings.set("wifi", nil)
    -- hs.settings.set("scenario", nil)
    -- hs.settings.set("power", nil)
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send():release()

