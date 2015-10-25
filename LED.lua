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

-- Gamma Correction
local GAMMA = {
  [0] = 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4,
  5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 13, 14, 15, 16, 16, 17,
  18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 34, 35, 36, 38,
  39, 41, 42, 44, 46, 47, 49, 51, 52, 54, 56, 58, 60, 61, 63, 65, 67,
  69, 71, 73, 76, 78, 80, 82, 84, 87, 89, 91, 94, 96, 98, 101, 103,
  106, 109, 111, 114, 117, 119, 122, 125, 128, 130, 133, 136, 139,
  142, 145, 148, 151, 155, 158, 161, 164, 167, 171, 174, 177, 181,
  184, 188, 191, 195, 198, 202, 206, 209, 213, 217, 221, 225, 228,
  232, 236, 240, 244, 248, 252, 257, 261, 265, 269, 274, 278, 282,
  287, 291, 295, 300, 304, 309, 314, 318, 323, 328, 333, 337, 342,
  347, 352, 357, 362, 367, 372, 377, 382, 387, 393, 398, 403, 408,
  414, 419, 425, 430, 436, 441, 447, 452, 458, 464, 470, 475, 481,
  487, 493, 499, 505, 511, 517, 523, 529, 535, 542, 548, 554, 561,
  567, 573, 580, 586, 593, 599, 606, 613, 619, 626, 633, 640, 647,
  653, 660, 667, 674, 681, 689, 696, 703, 710, 717, 725, 732, 739,
  747, 754, 762, 769, 777, 784, 792, 800, 807, 815, 823, 831, 839,
  847, 855, 863, 871, 879, 887, 895, 903, 912, 920, 928, 937, 945,
  954, 962, 971, 979, 988, 997, 1005, 1014, 1023
}

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
  red = GAMMA[red]
  green = GAMMA[green]
  blue = GAMMA[blue]

  -- Using a common-anode LED so high means turned off.
  if self.common_anode then
    red = 1023 - red
    green = 1023 - green
    blue = 1023 - blue
  end

  pwm.setduty(self.red_pin, red)
  pwm.setduty(self.blue_pin, green)
  pwm.setduty(self.green_pin, blue)
end

return LED
