#!/usr/bin/env bash

yad \
    --title="Power off system" \
    --button="Cancel" \
    --button="Reboot" \
    --button="Power off" \

case $? in
   1) reboot;;
   2) poweroff;;
esac