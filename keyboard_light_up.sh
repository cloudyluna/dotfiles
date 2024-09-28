#!/usr/bin/env bash

ls /sys/class/leds/input*
read -r -p "Which input number?: " scrollock_number
BRIGHTNESS_FILE="/sys/class/leds/input${scrollock_number}::scrolllock/brightness"
echo 1 | sudo tee "${BRIGHTNESS_FILE}" > /dev/null
cat "${BRIGHTNESS_FILE}"

exit

