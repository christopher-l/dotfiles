#!/usr/bin/env bash

set -euo pipefail

if ! id restic &> /dev/null; then
    echo "Creating user: restic..."
    useradd --system --create-home --shell /sbin/nologin restic
fi

if [ ! -f /root/restic.env ]; then
    echo "RESTIC_REPOSITORY=rest:https://restic.local.e6.freeddns.org/" > /root/restic.env
    echo -n "Provide the password for the backup repository: "
    read password
    echo "RESTIC_PASSWORD=$password" >> /root/restic.env
    echo "RESTIC_REST_USERNAME=chris" >> /root/restic.env
    echo -n "Provide the password for the backup REST service: "
    read password
    echo "RESTIC_REST_PASSWORD=$password" >> /root/restic.env
    chmod 600 /root/restic.env
    unset password
fi

systemctl enable --now restic-backup.timer
systemctl daemon-reload
