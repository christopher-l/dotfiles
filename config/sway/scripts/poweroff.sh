#!/usr/bin/env bash

function all() (
    yad \
        --title="Exit session" \
        --button="Cancel" \
        --button="Log out" \
        --button="Restart" \
        --button="Power off"

    case $? in
    1) swaymsg exit ;;
    2) systemctl reboot ;;
    3) systemctl poweroff ;;
    esac
)

function poweroff() (
    yad \
        --title="Power off system" \
        --button="Cancel" \
        --button="Power off"

    case $? in
    1) systemctl poweroff ;;
    esac
)

case "$1" in
all) all ;;
poweroff) poweroff ;;
esac
