#!/bin/bash

USE_BATTERY=0
BATTERY_STATUS='undefined'
PREV_STATE='undefined'


# Not charging - cable connected but battery full
# Discharging - using battery
# Charging - cable connected

if [ -f /sys/class/power_supply/BAT0/status ]; then
	BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
fi

if [ "$BATTERY_STATUS" = "Discharging" ]; then
	USE_BATTERY=1
fi

if [ -f /tmp/battery_status ]; then
	PREV_STATE=$(cat /tmp/battery_status)
fi

echo "USE_BATTERY=$USE_BATTERY" > /tmp/battery_status

# if [ "USE_BATTERY=$USE_BATTERY" != "$PREV_STATE" ]; then
# 	systemctl --user daemon-reload
# 	systemctl --user restart hypridle.service
# 	notify-send "Restart hypridle, battery mode has changed"
# fi
