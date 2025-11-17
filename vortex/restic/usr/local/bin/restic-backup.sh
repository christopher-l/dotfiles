#!/usr/bin/env bash

set -e

# Uncomment only for the first run.
#
#restic init

restic forget --prune \
    --keep-within-daily 7d \
    --keep-within-weekly 1m \
    --keep-within-monthly 1y \

restic backup \
    ~/Documents \
    ~/Backup/Vortex

restic check