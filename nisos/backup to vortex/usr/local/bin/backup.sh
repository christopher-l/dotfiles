#!/usr/bin/env bash

set -e

function main() (
    args=(
        -a
        --exclude=/dev
        --exclude=/sys
        --exclude=/proc
        --exclude=/run
        --exclude=/tmp
        --exclude=/media
        --exclude=/var/cache/
        --exclude=/mnt/wd-raid/Backup
        --exclude=/mnt/wd-raid/Incoming
        --exclude=/mnt/wd-raid/Video
        --exclude=.cache
        --exclude=.local/share/containers
        --exclude=.local/share/Trash
        --exclude=node_modules
        --exclude=.angular
        --exclude=".Trash-*"
        --delete
        --delete-excluded
    )

    dest=root@vortex:/mnt/hdd/backup/weekly.0/nisos
    args+=(
        -e ssh
    )

    echo rsync "${args[@]}" / $dest/
    rsync "${args[@]}" / $dest/
)

main
