local hyper = {"cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

require "moom"
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
    hs.reload()
  end
end

function startCaffeine(time)
  os.execute("/usr/bin/caffeinate -u -t " .. time .. " &")
end

caffeine_location = (os.getenv("HOME") .. "/Dropbox/Internal/custom/caffeine/caffeine")
function caffeineCheck(files)
  for _,file in pairs(files) do
    print(caffeine_location)
    print(file)
    if file == caffeine_location then
      startCaffeine(500)
      os.remove(file)
    end
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send():release()

hs.pathwatcher.new(os.getenv("HOME") .. "/.caffeine/", caffeineCheck):start()

