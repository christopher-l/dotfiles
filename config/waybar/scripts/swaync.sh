#!/usr/bin/env bash

WIDGET_SIGNAL=11

function getJSON() (
	if ! pgrep -x swaync >/dev/null; then
		cat <<-EOF
			{"text": "<span color=\"red\"></span>"}
		EOF
		return
	fi
	if [ "$(swaync-client -c)" == 0 ]; then
		icon=" "
	else
		icon=""
	fi
	cat <<-EOF
		{"text": "$icon"}
	EOF
)

function subscribeWidget() (
	while read line; do
		pkill -RTMIN+$WIDGET_SIGNAL waybar
	done < <(swaync-client -s)
)

case "$1" in
get-json) getJSON ;;
subscribe-widget) subscribeWidget ;;
esac
