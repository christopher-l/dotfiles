#!/usr/bin/env bash

# This doesn't currently work. Keeping for reference.

set -e

echo ">>> Installing Scanner Button Daemon"
yay -S scanbd

echo ">>> Copying /etc/sane.d/ to /etc/scanbd/sane.d/"
sudo cp -r /etc/sane.d/* /etc/scanbd/sane.d/

echo ">>> Updating /etc/sane.d/dll.conf"
# Comment out all non-empty lines that are not already commented out.
sudo sed -i '/^#\|^\s*$/!  s/^/#/' /etc/sane.d/dll.conf
# Activate 'net' driver
sudo sed -i 's/^#*\s*net$/net/' /etc/sane.d/dll.conf

echo ">>> Updating /etc/sane.d/net.conf"
# Comment out all non-empty lines that are not already commented out.
sudo sed -i '/^#\|^\s*$/!  s/^/#/' /etc/sane.d/net.conf
cat <<EOF | sudo tee -a /etc/sane.d/net.conf > /dev/null

# Configuration for Scanner Button Daemon
connect_timeout = 3
localhost # scanbm is listening on localhost
EOF

echo ">>> Updating /etc/scanbd/sane.d/dll.conf"
# Make sure the 'net' driver is commented out.
sudo sed -i 's/^net$/#net/' /etc/scanbd/sane.d/dll.conf

echo ">>> Starting and enabling Scanner Button Daemon"
sudo systemctl enable --now scanbd.service
sudo systemctl start scanbm.socket