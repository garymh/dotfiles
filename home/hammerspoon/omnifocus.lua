-- omnifocus
omni = hs.hotkey.modal.new({}, "f17")

function close_omni()
  hs.alert.closeAll()
  omni:exit()
end

omni:bind({}, 'escape', function() close_omni() end)

function omni:entered()
  hs.alert.show("Adding new task:", 10)
  hs.alert.show("fn: generic task", 10)
  hs.alert.show("t: @tech, h: @home, w: @work", 10)
  hs.alert.show("e: @errand, c: @pharmacy, p: @ups", 10)
  hs.alert.show("space bar: @store, i: @idea", 10)
  hs.alert.show("n: nufinancial", 10)
  hs.alert.show("l: members list", 10)
  hs.alert.show("s: space allocation", 10)
  hs.alert.show("also: (note), s(date), d(date), !", 10)
end

-- function omni:exited()
-- end

local function add_task(task_type)
  hs.applescript("tell application \"Alfred 3\" to run trigger \"" .. task_type .. "\" in workflow \"com.garys.stuff\"")
  close_omni()
end

omni:bind({}, 'f16',   function() hs.openConsole()    end)
omni:bind({}, 'f17',   function() add_task("generic") end)
omni:bind({}, 'm',     function() add_task("mac")     end)
omni:bind({}, 't',     function() add_task("tech")    end)
omni:bind({}, 'e',     function() add_task("errand")    end)
omni:bind({}, 'h',     function() add_task("home")    end)
omni:bind({}, 'n',     function() add_task("nufin")   end)
omni:bind({}, 'l',     function() add_task("members") end)
omni:bind({}, 's',     function() add_task("space")   end)
omni:bind({}, 'space', function() add_task("store")   end)
omni:bind({}, 'w',     function() add_task("work")    end)
omni:bind({}, 'p',     function() add_task("ups")     end)
omni:bind({}, 'c',     function() add_task("cvs")     end)
omni:bind({}, 'i',     function() add_task("idea")    end)
