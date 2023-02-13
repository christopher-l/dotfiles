#!/usr/bin/env bash

set -e

function print_usage_and_exit (
    echo "Usage: $0 script host"
    exit 1
)

if [ $# -ne 2 ]; then
    print_usage_and_exit
fi

script=$1
host=$2

function run_as_root (
    # echo "$@"
    if [ "$host" = $(hostname) ]; then
        sudo "$@"
    else
        ssh root@"$host" "${@@Q}"
    fi
)

function run_script (
    if [ "$host" = $(hostname) ]; then
        sudo "$1"
    else
        ssh "root@$host" "bash -s" -- < "$1"
    fi
)

function copy_file (
    path="$1"
    file="$2"
    if [ "$host" = $(hostname) ]; then
        sudo cp "$file" "/$path"
    else
        scp "$file" root@"$host":"/$path" > /dev/null
    fi
)

function install (
    if [ "$host" = $(hostname) ]; then
        echo "Installing locally..."
    else
        echo "Installing remotely..."
    fi
    install_dir
    if [ -f install.sh ]; then
        run_script ./install.sh
    fi
)

function install_dir (
    path="$1"
    if [ ! -d "/$path" ]; then
        run_as_root mkdir "/$path"
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
    copy_file "$path" "$file"
    echo "Installed file /$file"
)

function uninstall (
    echo uninstall
)

function main (
    cd "$script" || print_usage_and_exit
    cd "$host" || print_usage_and_exit
    install
)

main