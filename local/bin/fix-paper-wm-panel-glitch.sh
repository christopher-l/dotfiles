#!/usr/bin/env bash

set -e

SCHEMA_DIR=$HOME/.local/share/gnome-shell/extensions/paperwm@hedning:matrix.org/schemas

gsettings --schemadir $SCHEMA_DIR set org.gnome.Shell.Extensions.PaperWM use-workspace-name false
gsettings --schemadir $SCHEMA_DIR reset org.gnome.Shell.Extensions.PaperWM use-workspace-name