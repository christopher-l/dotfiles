#!/usr/bin/env bash

set -e

function apply_vscode() {
    local config_file="$HOME/.config/Code - OSS/User/settings.json"
    local dark_theme="Nord"
    local light_theme="GitHub Light"
    local selected_theme=$1_theme
    local theme=${!selected_theme}
    sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$theme\"/" "$config_file"
}

function apply_gnome_terminal() {
    local light_profile="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
    local dark_profile="20933993-f2c5-4352-8629-fd26d2c438c6"
    local selected_profile=$1_profile
    local profile=${!selected_profile}
    gsettings set org.gnome.Terminal.ProfilesList default $profile
}

case "$1" in
light | dark)
    apply_vscode $1
    apply_gnome_terminal $1
    ;;
*)
    echo "Usage:"
    echo "    $0 light"
    echo "or"
    echo "    $0 dark"
    exit 1
    ;;
esac
