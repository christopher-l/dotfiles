PATH="$HOME/.local/bin:$PATH"

PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

if [[ "$TERM" == alacritty ]]; then
    alias ssh='TERM=xterm-256color ssh'
fi
