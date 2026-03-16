#!/usr/bin/env bash

set -e

# Adapted from https://restic.readthedocs.io/en/stable/080_examples.html#backing-up-your-system-without-running-restic-as-root

if ! id restic &> /dev/null; then
    echo "Creating user: restic..."
    useradd --system --create-home --shell /sbin/nologin restic
    mkdir ~restic/bin
fi

if [ ! -f ~restic/bin/restic ]; then
    echo "Downloading restic..."
    curl -L --fail https://github.com/restic/restic/releases/download/v0.18.1/restic_0.18.1_linux_arm64.bz2 | bunzip2 > ~restic/bin/restic
    chown root:restic ~restic/bin/restic
    chmod 750 ~restic/bin/restic
    setcap cap_dac_read_search=+ep ~restic/bin/restic
fi

if [ ! -f ~restic/restic-password-local ]; then
    echo -n "Password for local backup repository: "
    read password
    if [ -n "$password" ]; then
        echo "$password" > ~restic/restic-password-local
        chmod 600 ~restic/restic-password-local
    fi
    unset password
fi

if ! sudo -u restic rclone config show gdrive: &> /dev/null; then
    sudo -u restic rclone config create gdrive drive --all \
        scope=drive \
        service_account_file= \
        config_fs_advanced=false \
        config_is_local=false \
        team_drive=
fi

if [ ! -f ~restic/restic-password-gdrive ]; then
    echo -n "Password for Google-Drive backup repository: "
    read password
    if [ -n "$password" ]; then
        echo "$password" > ~restic/restic-password-gdrive
        chmod 600 ~restic/restic-password-gdrive
    fi
    unset password
fi

systemctl daemon-reload
systemctl enable --now restic-local.timer
systemctl enable --now restic-gdrive.timer
systemctl enable --now restic-self-update.timer
systemctl enable --now restic-rest-server.service
