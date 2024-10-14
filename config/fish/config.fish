function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a -- l 'ls -l'
    abbr -a -- gsw 'git switch'
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    if ! systemctl --failed --quiet
        systemctl --failed
    end
end