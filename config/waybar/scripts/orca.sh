#!/usr/bin/env bash

set -e

WIDGET_SIGNAL=12

function getJson() (
	icon=""
	if systemctl --user is-active --quiet orca.service; then
		cat <<-EOF
			{"text": "$icon"}
		EOF
	else
		cat <<-EOF
			{"text": "$icon", "class": "inactive"}
		EOF
	fi
)

function toggle() (
	if systemctl --user is-active --quiet orca.service; then
		systemctl --user stop orca.service
	else
		systemctl --user start orca.service
	fi
	pkill -RTMIN+$WIDGET_SIGNAL waybar
)

case "$1" in
get-json) getJson ;;
toggle) toggle ;;
esac
