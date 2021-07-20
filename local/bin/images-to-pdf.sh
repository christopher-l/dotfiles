#!/usr/bin/env bash

set -e

if [ -z "$1" ]; then
    echo "Usage:"
    echo "    $0 <out-name> ...<image-file>"
    echo "E.g."
    echo "    $0 \"My Fancy Leaflet\" leaflet-file*.png"
    exit 1
fi

out_name=$1
shift
temp_dir=$(mktemp -d)
echo "Created temp dir: $temp_dir"
cp "$@" $temp_dir
pushd $temp_dir > /dev/null
echo "Removing alpha channel..."
for f in "$@"; do convert "$f" -background white -alpha remove -alpha off "$f"; done
echo "Creating pdf..."
img2pdf -o out.pdf --pagesize A4 --fit shrink "$@"
echo "Creating pdf (small version)..."
pdf2ps out.pdf out.ps
ps2pdf out.ps out-small.pdf
popd > /dev/null
cp "$temp_dir/out.pdf" "$out_name.pdf"
cp "$temp_dir/out-small.pdf" "$out_name-compressed.pdf"
echo "Done. Cleaning up."
rm -r $temp_dir