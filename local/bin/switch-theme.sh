#!/usr/bin/env bash

set -e

function apply_vscode {
    local config_file="$HOME/.config/Code - OSS/User/settings.json"
    local dark_theme="Visual Studio Dark"
    local light_theme="Visual Studio Light"
    local chosen_theme=$1_theme
    local theme=${!chosen_theme}
    sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$theme\"/" "$config_file"
}

# function apply_discord {
#     local config_file="$HOME/.var/app/com.discordapp.Discord/config/discord/settings.json"
#     local dark_theme="#202225"
#     local light_theme="#ffffff"
#     local chosen_theme=$1_theme
#     local theme=${!chosen_theme}
#     sed -i "s/\"BACKGROUND_COLOR\": \".*\"/\"BACKGROUND_COLOR\": \"$theme\"/" "$config_file"
# }

case "$1" in
    light|dark)
        apply_vscode $1
        # apply_discord $1
        ;;
    *)
        echo "Usage:"
        echo "    $0 light"
        echo "or"
        echo "    $0 dark"
        exit 1
        ;;
esac