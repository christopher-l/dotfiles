#!/usr/bin/env bash

set -e

systemctl daemon-reload
systemctl enable certbot-renew.timer
systemctl start certbot-renew.timer