#!/usr/bin/env bash

MODE_FILE="$XDG_RUNTIME_DIR/mako_mode"
mode=$(cat $MODE_FILE 2>/dev/null || echo "default")

function getIcon() (
    count=$(makoctl list | jq '.data[0] | length')
    if [ "$mode" == "default" ] && [ $count != 0 ]; then
        echo ""
    elif [ "$mode" == "do-not-disturb" ]; then
        echo ""
    else
        echo ""
    fi
)

function setMode() (
    makoctl set-mode "$1"
    echo "$1" >"$MODE_FILE"
)

function toggleMode() (
    touch "$LOCK_FILE"
    if [ "$mode" == "default" ]; then
        setMode "do-not-disturb"
    else
        setMode "default"
    fi
)

case $1 in
get-icon)
    getIcon
    ;;
toggle-mode)
    toggleMode
    ;;
*)
    echo "Unknown command $1"
    exit 1
    ;;
esac
