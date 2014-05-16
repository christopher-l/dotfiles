function b {
    exec "$@" &>/dev/null &
    disown
}
