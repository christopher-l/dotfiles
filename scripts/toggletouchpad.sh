#!/bin/bash

STATE=`synclient -l | grep Touch | awk {'printf $3'}`

if [ "$STATE" = "0" ]; then
    synclient TouchpadOff=1
else
    synclient TouchpadOff=0
fi
