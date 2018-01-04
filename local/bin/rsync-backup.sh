#!/bin/bash

set -e

source="/"
remote="root@torus"
dest="/mnt/hdd/backup/osprey"

args="-av --delete --numeric-ids --relative --delete-excluded"
exclude="{/dev,/sys,/proc,/run,/mnt,/tmp,/media,/home/*/.cache}"
ssh_command="ssh -i /home/chris/.ssh/id_rsa"

rsync_command="rsync $args --exclude=$exclude -e \"$ssh_command\" \
    $source/ $remote:$dest/sync/"

date=$(date +%Y-%m-%d)
snapshot_dest="$dest/$date"
snapshot_remote_command="[[ ! -e $snapshot_dest ]] && \
    cp -al $dest/sync $snapshot_dest"
snapshot_command="$ssh_command $remote \"$snapshot_remote_command\""

echo "$rsync_command"
eval "$rsync_command"

echo "$snapshot_command"
eval "$snapshot_command"
