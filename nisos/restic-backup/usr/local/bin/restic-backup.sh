#!/usr/bin/env bash

set -euo pipefail

restic backup / --exclude={/dev,/media,/mnt,/proc,/run,/sys,/tmp,/var/tmp} \
    --exclude=/var/cache/ \
    --exclude=/mnt/wd-raid/Backup \
    --exclude=/mnt/wd-raid/Incoming \
    --exclude=/mnt/wd-raid/Video \
    --exclude=/mnt/wd-raid/.Trash-1000 \
    --exclude=/home/*/.cache \
    --exclude=/home/*/.local/share/containers \
    --exclude=/home/*/.local/share/Trash \
    --exclude=node_modules \
    --exclude=.angular
