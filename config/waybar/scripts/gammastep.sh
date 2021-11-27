#!/usr/bin/env bash

set -e

periodFile="$XDG_RUNTIME_DIR/gammastep"

function getJson() (
	if ! pgrep gammastep >/dev/null; then
		cat <<-EOF
			{"text": "", "class": "not-running", "tooltip": "gammastep daemon not running"}
		EOF
		exit 0
	fi

	period=$(cat "$periodFile")

	case "$period" in
	daytime)
		cat <<-EOF
			{"text": "", "class": "daytime"}
		EOF
		;;

	transition)
		cat <<-EOF
			{"text": "", "class": "transition"}
		EOF
		;;

	night)
		cat <<-EOF
			{"text": "", "class": "night"}
		EOF
		;;

	none)
		cat <<-EOF
			{"text": "", "class": "inhibited"}
		EOF
		;;
	esac
)

function toggle() (
	pkill -USR1 gammastep
)

case "$1" in
get-json)
	echo "$(getJson)"
	;;
toggle)
	toggle
	;;
esac
