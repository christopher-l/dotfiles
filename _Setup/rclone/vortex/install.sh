#!/usr/bin/env bash

set -e

systemctl enable rclone@chris
systemctl restart rclone@chris
systemctl daemon-reload