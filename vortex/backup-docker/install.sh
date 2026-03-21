#!/usr/bin/env bash

set -e

if ! id backup-docker &> /dev/null; then
    echo "Creating user: backup-docker..."
    useradd --system --shell /sbin/nologin backup-docker
fi

systemctl daemon-reload
systemctl enable --now backup-docker.timer
