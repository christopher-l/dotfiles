#!/usr/bin/env bash

set -e

function print_usage_and_exit (
    echo "Usage: $0 host/script"
    exit 1
)

if [ $# -ne 1 ]; then
    print_usage_and_exit
fi

path=$(dirname "$1")/$(basename "$1")
host=$(echo $1 | cut -d '/' -f 1 -s)

function main (
    if [ -z "$host" ]; then
        cd "$path"
        install
    elif [ "$host" = $(hostname) ]; then
        echo "Installing locally..."
        cd "$path" || print_usage_and_exit
        install
    else
        echo "Installing remotely..."
        tmpDir=/tmp/setup.$(cat /dev/urandom | tr -cd 'a-zA-Z0-9' | head -c 10)
        echo "Copying to remote dir: $tmpDir"
        rsync -re ssh deploy.sh $path $host:$tmpDir/
        echo "Deploying..."
        ssh -t $host "cd $tmpDir; ./deploy.sh $(basename $path); errCode=\$?; rm -r $tmpDir; exit \$errCode"
    fi
)

function install (
    install_dir
    if [ -f install.sh ]; then
        sudo ./install.sh
    fi
)

function install_dir (
    path="$1"
    GLOBIGNORE=".:.."
    if ! sudo test -d "/$path"; then
        echo mkdir "/$path"
        sudo mkdir "/$path"
        echo "Created directory /$path"
    fi
    for f in "$path"*; do
        if [ -f "$f" ]; then
            # Ignore files on root level
            if [ -n "$path" ]; then
                install_file "$f" "$path"
            fi
        elif [ -d "$f" ]; then
            install_dir "$f/"
        else
            echo "Could not install file $f in $path"
            exit 1
        fi
    done
)

function install_file (
    file="$1"
    path="$2"
    sudo cp "$file" "/$path"
    echo "Installed file /$file"
)

main
