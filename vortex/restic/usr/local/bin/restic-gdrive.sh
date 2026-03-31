#!/usr/bin/env bash

set -euo pipefail

if systemctl is-active --quiet backup-docker; then
    echo "Error: backup-docker.service is running"
    exit 1
fi

echo "Removing old snapshots..."
restic forget --prune \
    --keep-within 14d \
    --keep-within-weekly 1m \
    --keep-within-monthly 1y

echo "Creating backup..."
restic backup /home/chris/Docker \
    --exclude='/home/chris/Docker/*/data' \
    --exclude='/home/chris/Docker/syncthing/media/Backup' \
    --exclude='/home/chris/Docker/syncthing/media/Pictures' \
    --exclude='/home/chris/Docker/syncthing/media/Media'

echo "Checking repository..."
restic check
