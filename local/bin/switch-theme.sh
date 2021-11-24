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
        # sed -i "s/\"editor.fontFamily\": \"\(.*\) Medium\"/\"editor.fontFamily\": \"\1\"/" "$config_file"
        ;;
    dark)
        sed -i "s/\"workbench.colorTheme\": \"\(.*\)Light\(.*\)\"/\"workbench.colorTheme\": \"\1Dark\2\"/" "$config_file"
        # Append "Medium" to the "fontFamily" value, but only if it currently doesn't have "Medium" as suffix.
        # sed -i -E '/\"editor\.fontFamily\": \"(.*)Medium\"/! s/\"editor\.fontFamily\": \"(.*)\"/\"editor\.fontFamily\": \"\1 Medium\"/' "$config_file"
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

function apply_ulauncher() {
    local config_file="$HOME/.config/ulauncher/settings.json"
    local dark_theme="dark"
    local light_theme="light"
    local selected_theme=$1_theme
    local theme=${!selected_theme}
    sed -i "s/\"theme-name\": \".*\"/\"theme-name\": \"$theme\"/" "$config_file"
    if pgrep -x ulauncher >/dev/null; then
        killall ulauncher && sleep 1 && ulauncher --hide-window &
    fi
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

function toggle_gtk_theme() (
    light_theme="'Adwaita'"
    dark_theme="'Adwaita-dark'"
    current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    if [[ $current_theme == $light_theme ]]; then
        gsettings set org.gnome.desktop.interface gtk-theme $dark_theme
        echo "dark"
    else
        gsettings set org.gnome.desktop.interface gtk-theme $light_theme
        echo "light"
    fi
)

function apply_all_applications() (
    apply_vscode $1
    apply_obsidian $1
    apply_ulauncher $1
    apply_qt5 $1
    # apply_gnome_terminal $1
)

case "$1" in
light | dark)
    apply_all_applications $1
    ;;
toggle)
    new_theme=$(toggle_gtk_theme)
    apply_all_applications $new_theme
    ;;
*)
    echo "Usage:"
    echo "    $0 light"
    echo "or"
    echo "    $0 dark"
    echo "or"
    echo "    $0 toggle"
    exit 1
    ;;
esac
