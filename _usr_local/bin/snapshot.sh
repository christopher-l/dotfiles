#!/bin/bash

set -e

subvolume=/${1:1}
snapshot=/snapshots/$1/$(date +%F)
cmd="btrfs subvolume snapshot -r $subvolume $snapshot"

eval $cmd
