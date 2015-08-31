local module = {
--[=[
    _NAME        = 'dateMenu',
    _VERSION     = '',
    _URL         = 'https://github.com/asmagill/hydra_config',
    _DESCRIPTION = [[
          Starting to replace itsyCal
    ]],
    _TODO        = [[]],
    _LICENSE     = [[ See README.md ]]
--]=]
}

local menubar    = require("hs.menubar")
local alert      = require("hs.alert")
local timer      = require("hs.timer")
local drawing    = require("hs.drawing")
local screen     = require("hs.screen")
local mouse      = require("hs.mouse")

local R, utf8 = pcall(require,"hs.utf8_53")
if not R then utf8 = require("hs.utf8") end

local dayInUTF8 = function(x)    --  U+2460-2473 = 1 - 20, U+3251-325F = 21 - 35
    if x < 21 then
        return utf8.codepointToUTF8(0x245F + x)
    else
        return utf8.codepointToUTF8(0x323C + x)
    end
end

local function secsToMidnight(z)
    local t = os.date("*t",z)
    t.hour=0    ; t.min=0    ; t.sec=0
    t.isdst=nil ; t.wday=nil ; t.yday=nil
    return os.time(t) + 86400 - os.time(os.date("*t",z))
end

module.changeDay = ""

local changeDayFunction, menu

changeDayFunction = function()
    menu:setTitle(tostring(dayInUTF8(os.date("*t").day)))
    module.changeDay = timer.doAfter(secsToMidnight(), changeDayFunction)
end

local visible = false

local textFont   = "Menlo"
local textSize   = 12
local blockSizeH = textSize * (4/3)
local blockSizeW = textSize * (2/3)

local edgeBuffer = 15

local calWidth   = 19
local calHeight  = 9
local textWidth  = blockSizeW * calWidth
local textHeight = blockSizeH * calHeight
local rectWidth  = textWidth  + 2 * edgeBuffer
local rectHeight = textHeight + 2 * edgeBuffer

local HLWidth    = blockSizeW  * 2
local HLHeight   = blockSizeH
local HLEdge     = 4

local HL         = drawing.rectangle{
                      x = 0,
                      y = 0,
                      h = HLHeight + 2,
                      w = HLWidth + 2
                  }:setFill(true):setStroke(false):setFillColor{
                      red = 1, blue = 1, green = 0, alpha = .6
                  }:setRoundedRectRadii(HLEdge, HLEdge)--:setStrokeWidth(4)

local rect       = drawing.rectangle{
                      x = 0,
                      y = 0,
                      h = rectHeight,
                      w = rectWidth
                  }:setFill(true):setStroke(false):setFillColor{
                      red = 0, blue = 0, green = 0, alpha = .8
                  }:setRoundedRectRadii(edgeBuffer, edgeBuffer)
local textRect   = drawing.text({
                      x = 0,
                      y = 0,
                      h = textHeight,
                      w = textWidth
                  },""):setTextFont(textFont):setTextSize(textSize):setTextColor{
                      red = 1, blue = 1, green = 1, alpha = 1
                  }

module.start = function()
    menu = menubar.new()
    module.menuUserdata = menu
    menu:setTitle(tostring(dayInUTF8(os.date("*t").day)))
    menu:setClickCallback(function()
        menu:setTitle(tostring(dayInUTF8(os.date("*t").day))) -- just in case timing off

        if visible then
            HL:hide()
            textRect:hide()
            rect:hide()
        else
            local text    = hs.execute("cal")
            local frame   = screen.mainScreen():frame()
            local clickAt = mouse.getAbsolutePosition()

-- newX and newY are approximate fixes for consolidateMenus.lua... now that we can't
-- assume we're in the menubar, gotta take some guesses and make some allowances...
            local newX = clickAt.x
            if newX + rectWidth > frame.x + frame.w then
                newX = frame.x + frame.w - rectWidth * .5
            end

            local newY = frame.y
            if clickAt.y > frame.y then
                newY =  screen:mainScreen():fullFrame().y + (frame.y - screen:mainScreen():fullFrame().y) * 2 + 6
            end

            rect:setTopLeft{
                x = newX - rectWidth * .5,
                y = newY
            }:show()

            local t = os.date("*t")
            t.day=1 ; t.wday=nil ; t.yday=nil

            local wom = (os.date("*t").day -
                        (os.date("*t").wday - os.date("*t",os.time(t)).wday) - 1) /
                        7

-- I really need to dig into how NSTextView goes into NSView and figure out why lining things
-- up is so damn picky...
            local dayOffset  = (os.date("*t").wday - 1) * 3 * (blockSizeW - .75)
            local weekOffset = (2 + wom) * (blockSizeH + 2.5)
--                  dayOffset  = (1 - 1) * 3 * (blockSizeW - .75)
--                  weekOffset = (2 + 2) * (blockSizeH + 2.5)
            HL:setTopLeft{
                x = newX - textWidth * .5 + dayOffset,
                y = newY + edgeBuffer + weekOffset
            }:show()

            textRect:setTopLeft{
                x = newX - textWidth * .5,
                y = newY + edgeBuffer
            }:setText(text):show()

        end
        visible = not visible
    end)

    module.changeDay = timer.doAfter(secsToMidnight(), changeDayFunction)
    return module
end

module.stop = function()
    module.changeDay:stop()
    module.changeDay = nil

    visible = false
    HL:hide()
    textRect:hide()
    rect:hide()
    menu:delete()
    menu = nil
    return module
end

module = setmetatable(module, {
  __gc = function(self)
      if module.changeDay then module.changeDay:stop() ; module.changeDay = nil end
      if HL then HL:delete() ; HL = nil end
      if textRect then textRect:delete() ; textRect = nil end
      if rect then rect:delete() ; rect = nil end
  end,
})

return module.start()
