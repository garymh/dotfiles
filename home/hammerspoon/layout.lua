function caffeineOff()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(false)
  spoon.Caffeine:stop()
end

function caffeineOn()
  spoon.Caffeine:start()
  spoon.Caffeine:setState(true)
end

function useLayout(layout)
  hs.notify.show("Switching to: " .. layout, "", "", "")

  if layout == "work" then
    caffeineOff()
  elseif layout == "superwork" then
    caffeineOff()
  elseif layout == "game" then
    caffeineOn()
  elseif layout == "chill" then
    caffeineOff()
  end
end
