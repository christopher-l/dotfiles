if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
end

if string match -q "$TERM_PROGRAM" "vscode"
     . (code --locate-shell-integration-path fish)
end