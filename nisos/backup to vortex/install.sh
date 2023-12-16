#!/usr/bin/env bash

set -e

systemctl enable backup.timer
systemctl daemon-reload