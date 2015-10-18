-- Copyright (C) 2015 snorecore
-- spooplights - init script config
-- Created: Sun 18th Oct 2015
--
-- Modify script and copy to init_config.lua before uploading.

-- WiFi Credentials
WIFI_SSID = ""
WIFI_PSK = ""

-- MQTT Connection
CLIENT_ID = "ESP"..node.chipid()
MQTT_SERVER = "iot.eclipse.org"
MQTT_PORT = 1883
MQTT_TOPIC = "cheerlightsRGB"

-- RGB LED Details
RED_PIN = 7
GREEN_PIN = 6
BLUE_PIN = 5
COMMON_ANODE = true
