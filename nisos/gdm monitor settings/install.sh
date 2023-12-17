#!/usr/bin/env bash

# From https://wiki.archlinux.org/title/GDM#Setup_default_monitor_settings

set -e

sudo -u gdm dbus-launch gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
systemctl daemon-reload