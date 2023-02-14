#!/usr/bin/env bash

set -e

#DEST=root@torus:/mnt/hdd/backup/_sync/nisos
DEST=/mnt/wd-raid/Backup/nisos

args=(
    -a
    # -P
    # --info=progress2
    #-e ssh
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
    --exclude=.m2/repository
    --exclude=.npm
    --exclude=.var/app/com.valvesoftware.Steam
    --exclude=node_modules
    --exclude=.angular
    --exclude=".Trash-*"
    --exclude=Backup
    # --exclude=/mnt/wd-raid/Video
    --delete
    --delete-excluded
)

echo rsync / "${args[@]}" $DEST/
rsync / "${args[@]}" $DEST/
