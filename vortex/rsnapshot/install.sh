#!/usr/bin/env bash

set -e

systemctl daemon-reload
systemctl enable --now rsnapshot-biannual.timer
systemctl enable --now rsnapshot-monthly.timer
systemctl enable --now rsnapshot-weekly.timer