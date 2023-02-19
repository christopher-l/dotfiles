PATH="$HOME/.local/bin:$PATH"

PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules
export NODE_PATH=~/.node_modules/lib/node_modules

if ! systemctl --failed --quiet; then
    systemctl --failed
fi

if [[ "$TERM" == alacritty ]]; then
    alias ssh='TERM=xterm-256color ssh'
fi