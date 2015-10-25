-- Copyright (C) 2015 snorecore
-- LED Library to drive a single RGB LED
-- Created: Sat 24th Oct 2015

local LED = {}
LED.__index = LED

-- Default values
LED.DEFAULT_RED_PIN = 5
LED.DEFAULT_BLUE_PIN = 6
LED.DEFAULT_GREEN_PIN = 7
LED.DEFAULT_PWM_FREQ = 100

-- LED Constructor
local function construct(self, red, green, blue, common_anode)
  self = self or {}

  -- Setup properties
  self.red_pin = red or LED.DEFAULT_RED_PIN
  self.green_pin = green or LED.DEFAULT_GREEN_PIN
  self.blue_pin = blue or LED.DEFAULT_BLUE_PIN
  self.common_anode = true or common_anode

  setmetatable(self, LED)
  return self
end
setmetatable(LED, {__call = construct})

-- Setup PWM on LED pins
function LED:start_PWM(freq)
  freq = freq or LED.DEFAULT_PWM_FREQ

  -- Setup pins with LEDs off.
  local col = 0
  if self.common_anode then
    col = 1023
  end

  pwm.setup(self.red_pin, freq, col)
  pwm.setup(self.green_pin, freq, col)
  pwm.setup(self.blue_pin, freq, col)

  -- Start PWM
  pwm.start(self.red_pin)
  pwm.start(self.green_pin)
  pwm.start(self.blue_pin)
end

function LED:stop_PWM()
  pwm.close(self.red_pin)
  pwm.close(self.green_pin)
  pwm.close(self.blue_pin)
end

-- Set RGB LED Colour using PWM
function LED:set_col(red, green, blue)

  -- PWM has 10-bit resolution, but just work with 8-bits.
  -- Assuming 0-255 input.
  red = bit.lshift(red, 2)
  green = bit.lshift(green, 2)
  blue = bit.lshift(blue, 2)

  -- Using a common-anode LED so high means turned off.
  if common_anode then
    red = 1023 - red
    green = 1023 - green
    blue = 1023 - blue
  end

  pwm.setduty(self.red_pin, red)
  pwm.setduty(self.blue_pin, green)
  pwm.setduty(self.green_pin, blue)
end

return LED
