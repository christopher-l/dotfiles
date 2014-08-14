#!/bin/bash

# adjust the display's backlight brightness logarithmically
# example call:
#   backlight.sh 2
#   backlight.sh 0.5

new_value=$(echo "$(xbacklight -get) * (${1}) +1" | bc)
xbacklight -set ${new_value}
killall -SIGUSR1 i3status
