-- Copyright (C) 2015 snorecore
-- Blink onboard LED
-- Created: Sun 18th Oct 2015

gpio.mode(3, gpio.OUTPUT)

LED = 3
led_on = false

function toggle_led()
  if led_on then
    gpio.write(LED, gpio.HIGH)
  else
    gpio.write(LED, gpio.LOW)
  end
  led_on = not led_on
end

tmr.alarm(0, 500, 1, toggle_led)
