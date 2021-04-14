local volume = {
    up = function()
        sendSystemKey("SOUND_UP")
    end,
    down = function()
        sendSystemKey("SOUND_DOWN")
    end,
    mute = function()
        sendSystemKey("MUTE")
    end
}

local function pause_key()
    sendSystemKey("PLAY")
end

powermate =
    hs.distributednotifications.new(
    function(name, object, userInfo)
        if object == "kPowermateKnobPress" then
            volume.mute()
        elseif object == "kPowermateKnobClockwise" then
            volume.up()
        elseif object == "kPowermateKnobCounterClockwise" then
            volume.down()
        end
    end,
    "kPowermateKnobNotification"
)
powermate:start()

hs.hotkey.bind(hyper, 'down', pause_key)
-- ramp the led, flash it slow, flash it quickly, turn it off.
for i=0,1,0.1
do
  hs.distributednotifications.post("kPowermateLEDNotification", "org.hammerspoon", { fn = "kPowermateLEDLevel", level=i})
  hs.timer.usleep(250000);
end

hs.timer.doAfter(1,
  function()
    hs.distributednotifications.post("kPowermateLEDNotification", "org.hammerspoon", { fn = "kPowermateLEDFlash", level=15})
    hs.timer.doAfter(10,
      function()
        hs.distributednotifications.post("kPowermateLEDNotification", "org.hammerspoon", { fn = "kPowermateLEDFlash", level=32})
        hs.timer.doAfter(2,
          function()
            hs.distributednotifications.post("kPowermateLEDNotification", "org.hammerspoon", { fn = "kPowermateLEDOff"})
          end
          )
      end
      )
  end
  )

