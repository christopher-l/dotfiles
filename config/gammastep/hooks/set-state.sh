#!/usr/bin/env bash

set -e

runtimeFile="$XDG_RUNTIME_DIR/gammastep"

case $1 in
period-changed)
    echo "$3" > "$runtimeFile"
    pkill -RTMIN+10 waybar
    ;;
esac
