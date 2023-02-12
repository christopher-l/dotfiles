#!/usr/bin/env bash

set -e

systemctl enable rsnapshot-daily.timer
systemctl enable rsnapshot-weekly.timer
systemctl enable rsnapshot-monthly.timer
systemctl enable rsnapshot-biannual.timer