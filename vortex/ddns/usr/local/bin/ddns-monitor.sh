#!/usr/bin/env bash

set -e

function get_ipv6() (
    ip -json -6 addr show scope global | jq -r '.[0].addr_info[0].local'
)

# Run update when the IPv6 address changes.
ip mon addr | while read line; do
    ipv6=$(get_ipv6)
    if [ "$ipv6" != "null" ] && [[ "$ipv6" != fd00:* ]] && [ "$ipv6" != "$prev_ipv6" ]; then
        systemctl restart ddns-update
    fi
    prev_ipv6="$ipv6"
done
