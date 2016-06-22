local hyper = {"cmd", "alt", "ctrl", "shift" }
hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

require "moom"
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
  os.execute("/usr/bin/caffeinate -d -i -m -s -u -t " .. time .. " &")
  os.execute("say 'caffeine enabled'")
end

caffeine_location = (os.getenv("HOME") .. "/iCloud/Internal/caffeine")
function caffeineCheck(files)
  for i,file in ipairs(files) do
    if file_exists(file) then
      startCaffeine(18000)
      os.remove(file)
    end
  end
end

function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

hs.pathwatcher.new(caffeine_location, caffeineCheck):start()
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send():release()
