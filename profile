PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/.local/share/go"

if ! systemctl --failed --quiet; then
    systemctl --failed
fi