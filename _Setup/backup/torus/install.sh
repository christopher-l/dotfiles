#!/usr/bin/env bash

set -e

systemctl enable rsnapshot-weekly.timer
systemctl enable rsnapshot-monthly.timer
systemctl enable rsnapshot-biannual.timer
systemctl enable backup-docker.timer
systemctl daemon-reload