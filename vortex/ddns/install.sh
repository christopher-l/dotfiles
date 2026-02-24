#!/usr/bin/env bash

set -e

/usr/local/bin/ddns-update.sh

systemctl daemon-reload
systemctl enable --now ddns-monitor.service
