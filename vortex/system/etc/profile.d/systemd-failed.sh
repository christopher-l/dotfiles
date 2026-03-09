# Print failed systemd services if there are any
if ! systemctl --failed --quiet; then
    systemctl --failed
fi
