# Created by newuser for 4.3.12

export PATH=/home/chris/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1

bindkey -M vicmd v edit-command-line

# Search ASCII-string from multiple files in the currect working directory
# E.g.
# search "foobar" "*.html"
# search "foobar" "*.html" myfolder
# By default we excluse dotted files and directoves (.git, .svn)
function search() {

        if [[ ! -n "$1" ]] ; then
                echo "Usage: search \"pattern\" \"*.filemask\" \"path\""
                return
        fi

        # Did we get path arg
        if [[ ! -n "$3" ]] ;
        then
                search_path="."
        else
                search_path="$3"
        fi

        # LC_CTYPE="posix" 20x increases performance for ASCII search
        # https://twitter.com/jlaurila/status/86750682094374912

        # We use specially tuned GREP colors - make sure you have GNU grep on OSX
        # https://github.com/miohtama/ztanesh/blob/master/README.rst

        GREP_COLORS="ms=01;37:mc=01;37:sl=:cx=01;30:fn=35:ln=32:bn=32:se=36" LC_CTYPE=POSIX \
        grep -Ri "$1" --line-number --before-context=3 --after-context=3 --color=always --include="$2" --exclude=".*" "$search_path"/*
}
