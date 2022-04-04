#!/usr/bin/env bash

# Shows a small popup window asking for a new workspace name and renames the currently active
# workspace accordingly.

set -e

DCONF_KEY=/org/gnome/desktop/wm/preferences/workspace-names

# Currently active workspace.
index=$(xdotool get_desktop)
# Ask user for new workspace name.
newName=$(
    zenity \
        --entry \
        --title="Rename Workspace" \
        --text="Enter a new name for workspace $((index + 1))" \
        ""
        # --entry-text="$((index + 1)): "
)
# Get workspace names list.
names=$(dconf read $DCONF_KEY)
# Update names list with new name.
names=$(node -pe "
        const a = eval(process.argv[1]);
        a[$index]='$newName';
        '[\'' + a.join('\', \'') + '\']'
    " "$names")
# Write updated names list to config.
dconf write $DCONF_KEY "$names"