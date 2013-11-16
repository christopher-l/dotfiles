background() {
  "$@" >/dev/null 2>&1 &; disown
}

alias -s pdf='background okular'

alias l='ls -l'
