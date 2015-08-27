#!/bin/bash

# adjust the display's backlight brightness logarithmically
# example call:
#   backlight.sh 2
#   backlight.sh 0.5

max_brightness=4437
brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
# rel_brightness=$(echo "100.0 * ${brightness}.0 / ${max_brightness}.0" | bc)
new_value=$(echo "($brightness * (${1}) * 100 / $max_brightness) +1" | bc)
echo $new_value
xbacklight -set ${new_value} -steps 1
# xbacklight -set ${new_value} -time 20 -steps 5
# killall -SIGUSR1 i3status
