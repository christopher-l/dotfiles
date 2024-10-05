PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/.local/share/go"

if ! systemctl --failed --quiet; then
    systemctl --failed
fi


# pnpm
export PNPM_HOME="/home/chris/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
