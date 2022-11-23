function restore_theme
    if type -q theme.sh; and test -e ~/.theme_history
        theme.sh (theme.sh -l|tail -n1)
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    # if test "$TERM_PROGRAM" != vscode
    #     restore_theme
    # end
end