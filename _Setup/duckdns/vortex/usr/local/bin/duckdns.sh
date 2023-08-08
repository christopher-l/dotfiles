#!/usr/bin/env bash

set -e

# Place a file with the following content under the given path.
#
# TOKEN=XXXXX-XXXX-XXXX-XXXXX
source /root/duckdns-token

ipv6="$(ip -json -6 addr show scope global | jq -r '.[0].addr_info[0].local')"

echo "Updating IPv4 address (letting Duck DNS figure out the address)..."
curl --no-progress-meter "https://www.duckdns.org/update?domains=tcc-wg&token=$TOKEN&ip="
echo
echo "Updating IPv6 address to $ipv6..."
curl --no-progress-meter "https://www.duckdns.org/update?domains=tcc-wg&token=$TOKEN&ip=&ipv6=$ipv6"
echo
