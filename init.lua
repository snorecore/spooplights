-- Copyright (C) 2015 snorecore
-- spooplights - init script
-- Created: Sun 18th Oct 2015

CONFIG_SCRIPT = "init_config.lua"
SCRIPT = "spoopy.lua"
USER_BUTTON = 3

-- Utility functions
function file_exists(filename)
  local f = file.open(filename, "r")
  if f ~= nil then
    file.close()
    return true
  else
    return false
  end
end

function run_scripts()
  if not button_pressed then
    -- Check files exist
    if not file_exists(CONFIG_SCRIPT) then
      print ("Config script \""..CONFIG_SCRIPT.."\" not found.")
    else
      print ("Running config script \""..CONFIG_SCRIPT.."\".")
      dofile(CONFIG_SCRIPT)
    end
    if not file_exists(SCRIPT) then
      print ("Main Script \""..SCRIPT.."\" not found.")
    else
        print ("Running main script \""..SCRIPT.."\".")
        dofile(SCRIPT)
    end
  end
end

-- Main code
pressed = false

-- Setup button interrupt
gpio.mode(USER_BUTTON, gpio.INT)
gpio.trig(USER_BUTTON, "down",
  function()
    pressed = true
    print("Execution interrupted.")
    tmr.stop(0)
  end
)

-- Run script after delay
tmr.alarm(0, 5000, 0, run_scripts)
