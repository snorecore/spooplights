# spooplights

This program provides a simple implementation of a CheerLights client for an
ESP8266 WiFi module running NodeMCU. An MQTT feed is used to obtain the latest
CheerLights colour, which is displayed by driving a single Piranha RGB LED using
PWM.

The script works, but the code to keep the ESP8266 online and communicating may
not be very robust, so use it at your peril ;) 👻

To use the script copy init_config_example.lua to init_config.lua, fill in your
WiFi details, and upload all the lua files to the ESP8266 using the Python-based
NodeMCU Uploader (https://github.com/kmpm/nodemcu-uploader/). I had trouble with
NodeMCU Uploader on Windows, so try luatool (https://github.com/4refr0nt/luatool)
if you do too. If anything goes wrong, press the user button within a few seconds
of the module booting and it'll stop the script from running.

Why Spooplights? This code was written to turn a spoopy/spooky plastic ghost
from Poundland into a CheerLight.

NOTE: These scripts will not run on the official NodeMCU builds. Too many
modules are included, leaving insufficient memory for this code. I recommend
using a custom build from http://frightanic.com/nodemcu-custom-build/,
including these modules: "node,file,gpio,wifi,net,pwm,tmr,uart,bit,mqtt".
