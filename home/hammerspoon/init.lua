sh     = require('sh')
-- require "btt"
require "moom"
require "hyper"
require "caffeine"
require "controlplane"

hs.ipc.cliInstall()

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
