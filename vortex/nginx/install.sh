#!/usr/bin/env bash

set -e

nginx -t
systemctl enable nginx
systemctl restart nginx