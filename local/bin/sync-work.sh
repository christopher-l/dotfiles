#!/usr/bin/env bash

set -e

here="$HOME/Work/"
there="red-tail:Work/"

args=(
    -aPh
    -e ssh
    --info=progress2
    --delete
)

case "$1" in
put)
    echo rsync "${args[@]}" "$here" "$there"
    rsync "${args[@]}" "$here" "$there"
    ;;
get)
    echo rsync "${args[@]}" "$there" "$here"
    rsync "${args[@]}" "$there" "$here"
    ;;
*)
    exit 1
    ;;
esac
