#!/usr/bin/env bash

set -euo pipefail

echo "Removing old snapshots..."
restic forget --prune \
    --keep-within 14d \
    --keep-within-weekly 1m \
    --keep-within-monthly 1y \
    --keep-within-yearly 5y

echo "Backing up local filesystem..."
restic backup / --exclude={/dev,/media,/mnt,/proc,/run,/sys,/tmp,/var/tmp}

echo "Checking repository..."
restic check
