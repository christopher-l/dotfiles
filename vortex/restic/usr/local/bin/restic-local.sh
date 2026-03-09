#!/usr/bin/env bash

set -euo pipefail

echo "Removing old snapshots..."
/home/restic/bin/restic forget --prune \
    --keep-within 14d \
    --keep-within-weekly 1m \
    --keep-within-monthly 1y \
    --keep-within-yearly 5y

echo "Backing up local filesystem..."
/home/restic/bin/restic backup / --exclude={/dev,/media,/mnt,/proc,/run,/sys,/tmp,/var/tmp}

echo "Checking repository..."
/home/restic/bin/restic check
