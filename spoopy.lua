-- Copyright (C) 2015 snorecore
-- Test PWM
-- Created: Sun 18th Oct 2015


local LED = require "LED"

local led = LED(RED_PIN, GREEN_PIN, BLUE_PIN, COMMON_ANODE)

led:start_PWM()

-- Rainbow Cycle
-- Ported and adapted from Python, originally from Adafruit LEDPixel Code
local i = 0
function rainbow_cycle()
  local r, g, b, j
  if i < 85 then
    r = i * 3
    g = 255 - i * 3
    b = 0
  elseif i < 170 then
    j = i - 85
    r = 255 - j * 3
    g = 0
    b = j * 3
  else
    j = i - 170
    r = 0
    g = j * 3
    b = 255 - j * 3
  end

  led:set_col(r, g, b)

  i = i + 1
  if i > 255 then
    i = 0
  end
end

tmr.alarm(0, 50, 1, rainbow_cycle)
