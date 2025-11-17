#!/usr/bin/env bash

set -e

# Before installation, encrypt the backup key using the following commands:
#
#  cd /root
#  # Enter the plaintext key
#  $EDITOR backup-key.txt
#  # Encrypt
#  systemd-creds encrypt --name=backup-key backup-key.txt backup-key.cred
#  # Safely delete the plaintext key
#  shred -u backup-key.txt
#
# See https://systemd.io/CREDENTIALS/ for details.
#
# ---
#
# Then initialize the repository using the command:
#
#   restic init
#
# providing both, the repository to be used for backups and the password chosen
# above. See
# https://restic.readthedocs.io/en/stable/030_preparing_a_new_repo.html for
# details.

systemctl daemon-reload
systemctl enable --now restic-daily.timer