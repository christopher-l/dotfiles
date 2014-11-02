#!/bin/bash

# adjust the display's backlight brightness logarithmically
# example call:
#   backlight.sh 2
#   backlight.sh 0.5

echo foo
new_value=$(echo "$(xbacklight -get) * (${1}) +1" | bc)
echo bar
xbacklight -set ${new_value} -time 100
echo baz
# killall -SIGUSR1 i3status
