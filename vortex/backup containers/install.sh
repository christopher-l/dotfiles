#!/usr/bin/env bash

set -e

systemctl daemon-reload
systemctl enable --now backup-containers.timer