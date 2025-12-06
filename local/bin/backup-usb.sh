#!/usr/bin/env bash

set -e

BACKUP_DRIVE="$1" # a | b | c

DEST="/run/media/chris/chris-backup-$BACKUP_DRIVE/backup"

args=(
    -a
    -P
    --info=progress2
    # --dry-run
    # --fsync
    --include=/home
    --include=$HOME
    --include=$HOME/'Backup/***'
    --include=$HOME/'Archive/***'
    --include=$HOME/'Documents/***'
    --include=$HOME/'Pictures/***'
    --include=/mnt
    --include=/mnt/wd-raid
    --include='/mnt/wd-raid/Persönlich/***'
    --exclude='*'
    --delete
    --delete-excluded
)

echo rsync "${args[@]}" "/" "$DEST/"
rsync "${args[@]}" "/" "$DEST/"