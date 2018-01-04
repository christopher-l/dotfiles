#!/bin/bash

# example usage:
#   volume.sh 5%-
#   volume.sh 5%+

lockfile_path=/tmp/my_volume.lock

lockfile -r 0 $lockfile_path || exit 1
amixer -D pulse set Master $1 unmute
rm -f $lockfile_path
killall -SIGUSR1 i3status
