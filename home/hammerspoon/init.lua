Hyper = { "cmd", "alt", "ctrl", "shift" }

hs.allowAppleScript(true)
hs.application.enableSpotlightForNameSearches(true)
hs.console.darkMode(true)
hs.console.consoleFont({ name = "FixedsysExcelsiorIIIb Nerd Font", size = 20 })
hs.console.outputBackgroundColor({ white = 0 })
hs.console.consoleCommandColor({ white = 1 })

function quietReload()
  hs.settings.set("quietReload", true)
  hs.reload()
end

require("hyper")
require("actions")
require("watchers")
require("callbacks")

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

Install.repos["gary"] = {
  url = "https://github.com/garymh/Spoons",
  desc = "Gary's Personal Spoons Fork",
  branch = "master",
}

Install:andUse("SendToOmniFocus", {
  config = { quickentrydialog = true, notifications = false },
  hotkeys = { send_to_omnifocus = { Hyper, "o" } },
  ["repo"] = "gary",
})

Install:andUse("Caffeine", {})

require("layout")

if hs.settings.get("quietReload") ~= true then
  Install:andUse("FadeLogo", { config = { default_run = 1.0 }, start = true })
else
  hs.settings.clear("quietReload")
end
