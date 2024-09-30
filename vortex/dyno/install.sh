#!/usr/bin/env bash

set -e

systemctl daemon-reload
systemctl enable dyno.timer
systemctl start dyno.timer