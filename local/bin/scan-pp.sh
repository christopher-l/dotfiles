#!/usr/bin/env bash

set -e

#echo $@ > args

tmp=$(mktemp -u --suffix=.pdf)
convert -density 300 -channel Y -brightness-contrast 0x20 +channel -contrast-stretch 5%x70% -compress jpeg -quality 85 "$3" "$tmp"
mv "$tmp" "$3"
