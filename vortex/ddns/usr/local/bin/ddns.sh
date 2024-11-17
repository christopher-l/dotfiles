#!/usr/bin/env bash

set -e

# Place a file with the following content under the given path.
#
# TOKEN=XXXXXXXXXXXXXXX
source /root/ddns-token

function get_ipv4() (
    curl -4 --no-progress-meter --fail ifconfig.me
)

function get_ipv6() (
    ip -json -6 addr show scope global | jq -r '.[0].addr_info[0].local'
)

function update() (
    ipv4="$(get_ipv4)"
    ipv6="$(get_ipv6)"
    echo "Updating addresses..."
    echo "  IPv4: $ipv4"
    echo "  IPv6: $ipv6"
    curl --no-progress-meter "https://api.dynu.com/nic/update?hostname=e6.freeddns.org&password=$TOKEN&myip=$ipv4&myipv6=$ipv6"
    echo
)

# Run update when the IPv6 address changes.
ip mon addr | while read line; do
    ipv6=$(get_ipv6)
    if [ "$ipv6" != "null" ] && [ "$ipv6" != "$prev_ipv6" ]; then
        update
    fi
    prev_ipv6="$ipv6"
done