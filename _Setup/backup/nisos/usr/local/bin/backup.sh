#!/usr/bin/env bash

set -e

function print_usage_and_exit() (
    echo "Usage: $0 (online|cold)"
    exit 1
)

if [ "$#" -ne 1 ]; then
    print_usage_and_exit
fi

preset="$1"

function main() (
    args=(
        -a
        --exclude=/dev
        --exclude=/sys
        --exclude=/proc
        --exclude=/run
        # --exclude=/mnt
        --exclude=/tmp
        --exclude=/media
        --exclude=/var/cache/
        --exclude=/var/lib/docker
        --exclude=.cache
        --exclude=.local/share/Trash
        --exclude=.m2/repository
        --exclude=.npm
        --exclude=.var/app/com.valvesoftware.Steam
        --exclude=node_modules
        --exclude=.angular
        --exclude=".Trash-*"
        --exclude=/mnt/wd-raid/Incoming
        --exclude=/mnt/wd-raid/Video
        --delete
        --delete-excluded
    )

    case "$preset" in
    online)
        dest=root@torus:/mnt/hdd/backup/weekly.0/nisos
        args+=(
            -e ssh
        )
        ;;
    cold)
        dest=/run/media/chris/backup/nisos
        args+=(
            -P
            --info=progress2
            --exclude=/mnt/wd-raid/Backup
            --exclude=/mnt/wd-raid/Music
            --exclude=/mnt/wd-raid/VMs
        )
        ;;
    *)
        print_usage_and_exit
        ;;
    esac

    echo rsync "${args[@]}" / $dest/
    rsync "${args[@]}" / $dest/
)

main
