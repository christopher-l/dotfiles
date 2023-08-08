#!/usr/bin/env bash

set -e

systemctl enable duckdns.timer
systemctl start duckdns.timer
systemctl daemon-reload