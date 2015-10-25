-- Copyright (C) 2015 snorecore
-- Test PWM
-- Created: Sun 18th Oct 2015

function parse_colour(colour)
  -- Strip whitespace
  str = colour:match("[^%s]+", 0):lower()
  if str:match("^#") then
    rhex = tonumber(str:sub(2,3), 16)
    ghex = tonumber(str:sub(4,5), 16)
    bhex = tonumber(str:sub(6,7), 16)
    return rhex, ghex, bhex
  else
    return 0, 0, 0
  end
end

local LED = require "LED"

local led = LED(RED_PIN, GREEN_PIN, BLUE_PIN, COMMON_ANODE)

led:start_PWM(100)

-- Connect to the wifis
wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_SSID, WIFI_PSK)
wifi.sta.connect()
tmr.delay(1000000)

-- Connect to MQTT
m = mqtt.Client(CLIENT_ID, 120, "", "")
m:on("connect", function(con) print ("connected") end)
m:on("offline", function(con) print ("offline") end)
m:on("message",
function(conn, topic, data)
  if data ~= nil then
    print(data)
    local r, g, b = parse_colour(data)
    print ("Setting colour: R:"..r.." G:"..g.." B:"..b)
    led:set_col(r, g, b)
  end
end)

function mqtt_connected(client)
  print("connected")
  client:subscribe(MQTT_TOPIC,0,
    function(conn)
      print("subscribe success")
    end
  )
end

m:connect(MQTT_SERVER, MQTT_PORT, 0, mqtt_connected)
