#!/usr/bin/env bash

set -e

function main() (
    args=(
        -a
        --exclude=/dev
        --exclude=/sys
        --exclude=/proc
        --exclude=/run
        --exclude=/mnt
        --exclude=/tmp
        --exclude=/media
        --exclude=/var/cache/
        --exclude=/var/lib/docker
        --exclude=.cache
        --exclude=.local/share/Trash
        # --exclude=.npm
        # --exclude=.node_modules
        --exclude=.var/app/com.valvesoftware.Steam
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
