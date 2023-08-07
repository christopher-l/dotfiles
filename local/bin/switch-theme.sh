#!/usr/bin/env bash

set -e

function apply_vscode() {
    local config_file="$HOME/.config/Code - OSS/User/settings.json"
    # Select specific theme
    # local dark_theme="Tailwind Moon"
    # local light_theme="Tailwind Breeze"
    # local selected_theme=$1_theme
    # local theme=${!selected_theme}
    # sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$theme\"/" "$config_file"

    # Toggle "~ Dark" / "~ Light"
    case "$1" in
    light)
        sed -i --follow-symlinks "s/\"workbench.colorTheme\": \"\(.*\)Dark\(.*\)\"/\"workbench.colorTheme\": \"\1Light\2\"/" "$config_file"
        # sed -i "s/\"editor.fontFamily\": \"\(.*\) Medium\"/\"editor.fontFamily\": \"\1\"/" "$config_file"
        ;;
    dark)
        sed -i --follow-symlinks "s/\"workbench.colorTheme\": \"\(.*\)Light\(.*\)\"/\"workbench.colorTheme\": \"\1Dark\2\"/" "$config_file"
        # Append "Medium" to the "fontFamily" value, but only if it currently doesn't have "Medium" as suffix.
        # sed -i -E '/\"editor\.fontFamily\": \"(.*)Medium\"/! s/\"editor\.fontFamily\": \"(.*)\"/\"editor\.fontFamily\": \"\1 Medium\"/' "$config_file"
        ;;
    esac
    # Trigger VSCode reload
    mv "$config_file" "$config_file.bak"
    mv "$config_file.bak" "$config_file"
}

function apply_obsidian() {
    local config_file="$HOME/.config/obsidian/appearance.json"
    local dark_theme="obsidian"
    local light_theme="moonstone"
    local selected_theme=$1_theme
    local theme=${!selected_theme}
    sed -i "s/\"theme\": \".*\"/\"theme\": \"$theme\"/" "$config_file"
}

function apply_ulauncher() {
    local config_file="$HOME/.config/ulauncher/settings.json"
    local dark_theme="dark"
    local light_theme="light"
    local selected_theme=$1_theme
    local theme=${!selected_theme}
    sed -i "s/\"theme-name\": \".*\"/\"theme-name\": \"$theme\"/" "$config_file"
    if systemctl --user is-active --quiet ulauncher.service; then
        systemctl --user reload-or-restart ulauncher.service
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
    if [[ -f $config_file ]]; then
        local dark_theme="Adwaita-Dark"
        local light_theme="Adwaita"
        local selected_theme=$1_theme
        local theme=${!selected_theme}
        sed -i "s/^style=.*$/style=$theme/" "$config_file"
    fi
}

function apply_chromium() (
    config_file="$HOME/.config/chromium-flags.conf"
    case "$1" in
    light)
        sed -i '/--force-dark-mode/d' "$config_file"
        ;;
    dark)
        echo "--force-dark-mode" >> "$config_file"
        ;;
    esac
)

light_gtk_theme="'Adwaita'"
dark_gtk_theme="'Adwaita-dark'"
function get_current_theme() (
    current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    if [[ $current_theme == $light_gtk_theme ]]; then
        echo "light"
    else
        echo "dark"
    fi
)

function apply_gtk_theme() (
    case "$1" in
    light)
        gsettings set org.gnome.desktop.interface gtk-theme $light_gtk_theme
        ;;
    dark)
        gsettings set org.gnome.desktop.interface gtk-theme $dark_gtk_theme
        ;;
    esac
)

function toggle_gtk_theme() (
    current_theme=$(get_current_theme)
    if [[ $current_theme == "light" ]]; then
        apply_gtk_theme "dark"
        echo "dark"
    else
        apply_gtk_theme "light"
        echo "light"
    fi
)

function get_icon() (
    current_theme=$(get_current_theme)
    if [[ $current_theme == "light" ]]; then
        echo ""
    else
        echo ""
    fi
)

function apply_icon_theme() (
    light_theme="'Papirus-Light'"
    dark_theme="'Papirus-Dark'"
    case "$1" in
    light)
        gsettings set org.gnome.desktop.interface icon-theme $light_theme
        ;;
    dark)
        gsettings set org.gnome.desktop.interface icon-theme $dark_theme
        ;;
    esac
)

function apply_all_applications() (
    # apply_vscode $1
    # apply_obsidian $1
    # apply_ulauncher $1
    # apply_qt5 $1
    # apply_gnome_terminal $1
    # apply_chromium $1
)


case "$1" in
light | dark)
    apply_all_applications $1
    ;;
toggle)
    new_theme=$(toggle_gtk_theme)
    apply_icon_theme $new_theme
    apply_all_applications $new_theme
    ;;
get-current)
    get_current_theme
    ;;
get-icon)
    get_icon
    ;;
*)
    echo "Usage:"
    echo "    $0 light"
    echo "or"
    echo "    $0 dark"
    echo "or"
    echo "    $0 toggle"
    echo "or"
    echo "    $0 get-current"
    echo "or"
    echo "    $0 get-icon"
    exit 1
    ;;
esac
