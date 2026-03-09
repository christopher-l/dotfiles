#!/usr/bin/env bash

set -euo pipefail

echo "Removing old snapshots..."
/home/restic/bin/restic forget --prune \
    --keep-within 14d \
    --keep-within-weekly 1m \
    --keep-within-monthly 1y

echo "Creating backup..."
/home/restic/bin/restic backup /home/chris/Docker \
    --exclude='/home/chris/Docker/*/data' \
    --exclude='/home/chris/Docker/syncthing/media/Pictures' \
    --exclude='/home/chris/Docker/syncthing/media/Media'

echo "Checking repository..."
/home/restic/bin/restic check
