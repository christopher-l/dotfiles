#!/bin/sh
#
# This script toggles the extended monitor outputs if something is connected
#

# your notebook monitor
DEFAULT_OUTPUT='LVDS1'
#DEFAULT_OUTPUT='LVDS-0'

# outputs to toggle if connected
OUTPUTS='VGA1 HDMI1 DP1'
#OUTPUTS='VGA-0 DP-0 DP-3'

# get info from xrandr
XRANDR=`xrandr`

EXECUTE="xrandr --output $DEFAULT_OUTPUT --auto "

for CURRENT in $OUTPUTS
do
        if [[ $XRANDR == *$CURRENT\ connected*  ]] # is connected
        then
                if [[ $XRANDR == *$CURRENT\ connected\ \(* ]] # is disabled
                then
                        EXECUTE+="--output $CURRENT --auto --right-of $DEFAULT_OUTPUT "
                else
                        EXECUTE+="--output $CURRENT --off "
                fi
        else # make sure disconnected outputs are off 
                EXECUTE+="--output $CURRENT --off "
        fi
done

echo "$EXECUTE"
$EXECUTE
