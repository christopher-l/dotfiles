#!/usr/bin/env bash

set -e

function apply_vscode() {
    local config_file="$HOME/.config/Code - OSS/User/settings.json"
    # Select specific theme

    # local dark_theme="Visual Studio Dark"
    # local light_theme="Visual Studio Light"
    # local selected_theme=$1_theme
    # local theme=${!selected_theme}
    # sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$theme\"/" "$config_file"

    # Toggle "~ Dark" / "~ Light"
    case "$1" in
    light)
        sed -i "s/\"workbench.colorTheme\": \"\(.*\)Dark\(.*\)\"/\"workbench.colorTheme\": \"\1Light\2\"/" "$config_file"
        ;;
    dark)
        sed -i "s/\"workbench.colorTheme\": \"\(.*\)Light\(.*\)\"/\"workbench.colorTheme\": \"\1Dark\2\"/" "$config_file"
        ;;
    esac
}

function apply_obsidian() {
    local workspaces=("$HOME/Documents/Zettelkasten")
    for i in ${!workspaces[@]}; do
        local config_file="${workspaces[$i]}/.obsidian/appearance.json"
        local dark_theme="obsidian"
        local light_theme="moonstone"
        local selected_theme=$1_theme
        local theme=${!selected_theme}
        sed -i "s/\"theme\": \".*\"/\"theme\": \"$theme\"/" "$config_file"
    done

}

function apply_gnome_terminal() {
    local light_profile="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
    local dark_profile="20933993-f2c5-4352-8629-fd26d2c438c6"
    local selected_profile=$1_profile
    local profile=${!selected_profile}
    gsettings set org.gnome.Terminal.ProfilesList default $profile
}

function apply_qt5() {
    local config_file="$HOME/.config/qt5ct/qt5ct.conf"
    local dark_theme="Adwaita-Dark"
    local light_theme="Adwaita"
    local selected_theme=$1_theme
    local theme=${!selected_theme}
    sed -i "s/^style=.*$/style=$theme/" "$config_file"
}

case "$1" in
light | dark)
    apply_vscode $1
    apply_obsidian $1
    apply_qt5 $1
    # apply_gnome_terminal $1
    ;;
*)
    echo "Usage:"
    echo "    $0 light"
    echo "or"
    echo "    $0 dark"
    exit 1
    ;;
esac
