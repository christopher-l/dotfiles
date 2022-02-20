function __seen_non_option_argument
    set --local tokens (commandline --current-process --tokenize --cut-at-cursor)
    set --erase tokens[1]
    for t in $tokens
        if string match --quiet -- "--" $t
            return 1
        end
        if string match --regex --quiet -- "^[A-z0-9]" $t
            return 1
        end
    end
    return 0
end

# We allow option flags, but only as long as the command has not started.
complete -c fe -n __seen_non_option_argument -s h -l help -d 'Print help message and exit'
complete -c fe -n __seen_non_option_argument -s v -l verbose -d 'Print all information of each run'
# Complete anything that was valid without the `fe` command.
complete -c fe -x -a "(__fish_complete_subcommand --commandline $argv)"
