#!/usr/bin/env bash

set -e

TOTAL_WORKSPACES=22

getFirstEmptyWorkspace() (
    activeWorkspaces=$(swaymsg -t get_tree | jq '.nodes[].nodes[].num | select(. != null)')
    for i in $(seq 1 $TOTAL_WORKSPACES); do
        if ! grep -E -q "^$i$" <<<"$activeWorkspaces"; then
            echo $i
            exit 0
        fi
    done
    exit 1
)

firstEmptyWorkspace=$(getFirstEmptyWorkspace)

case "$1" in
focus) swaymsg workspace number $firstEmptyWorkspace ;;
move) swaymsg move container to workspace number $firstEmptyWorkspace ;;
move-and-focus)
    swaymsg move container to workspace number $firstEmptyWorkspace
    swaymsg workspace number $firstEmptyWorkspace
    ;;
esac
