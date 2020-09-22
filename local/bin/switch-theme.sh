#!/usr/bin/env bash

set -e

case "$1" in
    light)
        sed -i 's/"workbench.colorTheme": "Visual Studio Dark"/"workbench.colorTheme": "Visual Studio Light"/' "$HOME/.config/Code - OSS/User/settings.json"
        ;;
    dark)
        sed -i 's/"workbench.colorTheme": "Visual Studio Light"/"workbench.colorTheme": "Visual Studio Dark"/' "$HOME/.config/Code - OSS/User/settings.json"
        ;;
esac