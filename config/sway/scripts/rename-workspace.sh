#!/usr/bin/env bash

# Shows a small popup window asking for a new workspace name and renames the currently active
# workspace accordingly.

set -e

# Currently active workspace.
index=$(swaymsg -t get_workspaces | jq -c '.[] | select( .focused == true ).num')
oldName=$(swaymsg -t get_workspaces | jq -c '.[] | select( .focused == true ).name' | sed -r 's/^\"[0-9]+: (.*)\"$/\1/')
# Ask user for new workspace name.
newName=$(
    zenity \
        --entry \
        --title="Rename Workspace" \
        --text="Enter a new name for workspace $index." \
        --entry-text="$oldName"
)

swaymsg rename workspace to "$index: $newName"