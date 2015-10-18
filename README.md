# spooplights

This program provides a simple implementation of a CheerLights client for an ESP8266 WiFi module running NodeMCU.
An MQTT feed is used to obtain the latest CheerLights colour, which is displayed by driving a single Piranha RGB LED
using PWM.

The script works, but the code to keep the ESP8266 online and communicating may not be very robust, so use it at your peril ;) 👻

To use the script copy init_example.lua to init.lua, fill in your WiFi details, and upload all the lua files to the
ESP8266 using the Python-based NodeMCU Uploader (https://github.com/kmpm/nodemcu-uploader/). If anything goes wrong, press the user button within a few seconds of the module booting and it'll stop the script from running.

Why Spooplights? This code was written to turn a spoopy/spooky plastic ghost from poundland into a CheerLight.
