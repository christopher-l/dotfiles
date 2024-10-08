#!/usr/bin/env bash

set -e

# Place a file with the following content under the given path.
#
# TOKEN=XXXXXXXXXXXXXXX
source /root/dyno-token

ipv4=$(curl -4 --no-progress-meter --fail ifconfig.me)
ipv6="$(ip -json -6 addr show scope global | jq -r '.[0].addr_info[0].local')"

echo "Updating addresses..."
echo "  IPv4: $ipv4"
echo "  IPv6: $ipv6"
curl --no-progress-meter "https://api.dynu.com/nic/update?hostname=e6.freeddns.org&password=$TOKEN&myip=$ipv4&myipv6=$ipv6"
echo
