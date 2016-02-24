-- omnifocus
omni = hs.hotkey.modal.new({}, "f17")
omni:bind({}, 'escape', function() omni:exit() end)

function omni:entered()
  hs.alert.show("Adding new task:")
  hs.alert.show("fn: generic task")
  hs.alert.show("t: @tech, h: @home, w: @work")
  hs.alert.show("e: @errand, c: @pharmacy, p: @ups")
  hs.alert.show("space bar: @store, i: @idea")
  hs.alert.show("n: nufinancial")
  hs.alert.show("l: members list")
  hs.alert.show("s: space allocation")
  hs.alert.show("also: (note), s(date), d(date), !")
end

-- function omni:exited()
-- end

local function add_task(task_type)
  hs.applescript("tell application \"Alfred 2\" to run trigger \"" .. task_type .. "\" in workflow \"com.garys.stuff\"")
  omni:exit()
end

omni:bind({}, 'f16',   function() hs.openConsole()    end)
omni:bind({}, 'f17',   function() add_task("generic") end)
omni:bind({}, 'm',     function() add_task("mac")     end)
omni:bind({}, 't',     function() add_task("tech")    end)
omni:bind({}, 'h',     function() add_task("home")    end)
omni:bind({}, 'n',     function() add_task("nufin")   end)
omni:bind({}, 'l',     function() add_task("members") end)
omni:bind({}, 's',     function() add_task("space")   end)
omni:bind({}, 'space', function() add_task("store")   end)
omni:bind({}, 'w',     function() add_task("work")    end)
omni:bind({}, 'p',     function() add_task("ups")     end)
omni:bind({}, 'c',     function() add_task("cvs")     end)
omni:bind({}, 'i',     function() add_task("idea")    end)
