#!/usr/bin/env bash

set -e

if ! id restic &> /dev/null; then
    echo "Creating user: restic..."
    useradd --system --create-home --shell /sbin/nologin restic
fi

if [ ! -f ~restic/restic-password-local ]; then
    echo -n "Password for local backup repository: "
    read password
    if [ -n "$password" ]; then
        echo "$password" > ~restic/restic-password-local
        chown restic:restic ~restic/restic-password-local
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
        chown restic:restic ~restic/restic-password-gdrive
        chmod 600 ~restic/restic-password-gdrive
    fi
    unset password
fi

if ! grep -q chris /etc/restic-rest-server/users.htpasswd; then
    echo -n "Password for REST server: "
    read password
    if [ -n "$password" ]; then
        echo "$password" | htpasswd -B -c -i /etc/restic-rest-server/users.htpasswd chris
        chown root:restic /etc/restic-rest-server/users.htpasswd
    fi
fi

systemctl daemon-reload
systemctl enable --now restic-local.timer
systemctl enable --now restic-gdrive.timer
systemctl enable --now restic-rest-server.service
