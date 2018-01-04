#!/bin/bash

# example call:
# custom-modeline.sh HDMI1 1920 1080 60

modeline=$(cvt $2 $3 $4 | tail -n1 | cut -d " " -f 2-)
modename=$(cvt $2 $3 $4 | tail -n1 | cut -d " " -f 2)

xrandr --newmode $modeline
xrandr --addmode $1 $modename
xrandr --output $1 --mode $modename --right-of LVDS1

# nitrogen --restore
