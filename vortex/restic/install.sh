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

if [ ! -f ~restic/restic-password-local.cred ]; then
    echo -n "Provide the password for the local backup repository: "
    read password
    if [ -n "$password" ]; then
        echo "$password" | systemd-creds encrypt - ~restic/restic-password-local.cred
    fi
    unset password
fi

systemctl daemon-reload
systemctl enable --now restic-local.timer
