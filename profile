PATH="$HOME/.local/bin:$PATH"

if ! systemctl --failed --quiet; then
    systemctl --failed
fi