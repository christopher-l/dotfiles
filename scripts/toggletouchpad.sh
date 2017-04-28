#!/bin/sh

DEVICE=11
STATE=`xinput list-props $DEVICE | grep "Device Enabled" | awk {'printf $4'}`

if [ "$STATE" = "0" ]; then
    xinput enable $DEVICE
else
    xinput disable $DEVICE
fi
