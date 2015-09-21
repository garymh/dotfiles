local hyper = {"cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, 'n', function() os.execute("open ~") end)
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

require "moom"
-- require "calendar"
require "omnifocus"
require "controlplane"

-- if print(os.execute("scutil --nc status \"NU VPN\" | grep -q Connected")) == 0 then
--   hs.alert("if")
-- else
--   hs.alert("else")
-- end
-- if hs.execute("scutil --nc status 'NU VPN' | grep -q Connected").status == true then
--   hs.alert("if")
-- else
--   hs.alert("else")
-- end
-- hs.alert(hs.execute("scutil --nc status 'NU VPN'").output)
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

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send():release()
