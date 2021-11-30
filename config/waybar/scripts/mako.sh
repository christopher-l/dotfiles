#!/usr/bin/env bash

RUNTIME_DIR="$XDG_RUNTIME_DIR/mako"
UNSEEN_DIR="$RUNTIME_DIR/unseen"

mkdir -p "$UNSEEN_DIR"

MODE_FILE="$XDG_RUNTIME_DIR/mako/mode"
mode=$(cat $MODE_FILE 2>/dev/null || echo "default")

function getIcon() (
	unseenCount=$(ls $UNSEEN_DIR -1q | wc -l)
	if [ "$mode" == "default" ] && [ ! -z "$(ls $UNSEEN_DIR)" ]; then
		icon=""
	elif [ "$mode" == "do-not-disturb" ]; then
		icon=""
	else
		icon=""
	fi
	if [ "$unseenCount" == 0 ]; then
		tooltip=""
	elif [ "$unseenCount" == 1 ]; then
		tooltip="1 notification"
	else
		tooltip="$unseenCount notifications"
	fi
	cat <<-EOF
		{"text": "$icon", "tooltip": "$tooltip"}
	EOF
)

function setMode() (
	makoctl set-mode "$1"
	echo "$1" >"$MODE_FILE"
)

function toggleMode() (
	if [ "$mode" == "default" ]; then
		setMode "do-not-disturb"
	else
		setMode "default"
	fi
	reloadWaybar
)

function toggleRestore() (
	count=$(makoctl list | jq '.data[0] | length')
	if [ $count == 0 ]; then
		restoreAll
	else
		makoctl dismiss --all
	fi
	reloadWaybar
)

function restoreAll() (
	unseen=$(ls "$UNSEEN_DIR")
	for id in $unseen; do
		makoctl restore -n "$id"
	done
)

function onNotify() (
	touch "$UNSEEN_DIR/$1"
	reloadWaybar
)

function onDismiss() (
	rm "$UNSEEN_DIR/$1"
	reloadWaybar
)

function reloadWaybar() (
	sleep 0.05
	pkill -RTMIN+8 waybar
)

case $1 in
get-icon)
	getIcon
	;;
toggle-mode)
	toggleMode
	;;
toggle-restore)
	toggleRestore
	;;
on-notify)
	onNotify "$2"
	;;
on-dismiss)
	onDismiss "$2"
	;;
*)
	echo "Unknown command $1"
	exit 1
	;;
esac
