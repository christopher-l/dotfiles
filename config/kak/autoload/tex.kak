hook global BufCreate .*[.](tex) %{
    set buffer filetype tex
}

decl str pdflatexcmd pdflatex

def pdflatex -docstring "pdflatex wrapper" %{ %sh{
     output=$(mktemp -d -t kak-pdflatex.XXXXXXXX)/fifo
     mkfifo ${output}
     ( eval ${kak_opt_pdflatexcmd} ${kak_bufname} > ${output} 2>&1 ) > /dev/null 2>&1 < /dev/null &

     echo "eval -try-client '$kak_opt_toolsclient' %{
               edit! -fifo ${output} -scroll *pdflatex*
               set buffer filetype pdflatex
               hook -group fifo buffer BufCloseFifo .* %{
                   nop %sh{ rm -r $(dirname ${output}) }
                   rmhooks buffer fifo
               }
           }"
}}

addhl -group / regions -default code tex \
    brackets_arg "\[" "\]"            '' \
    math         "\$" "\$"            '' \
    comment      \%   '$'             ''

addhl -group /tex/comment       fill comment
addhl -group /tex/brackets_arg  fill string
addhl -group /tex/math          fill value

addhl -group /tex/code regex \\[A-Za-z]* 0:identifier

def -hidden _tex_indent_on_new_line %{
    eval -draft -itersel %{
        # preserve previous line indent
        try %{ exec -draft <space> K <a-&> }
    }
}

hook global WinSetOption filetype=tex %{
    addhl ref tex
    hook buffer -group tex-indent InsertChar \n _tex_indent_on_new_line
}

hook global WinSetOption filetype=(?!tex).* %{ rmhl tex; rmhooks buffer tex-indent }

hook global WinSetOption filetype=pdflatex %{
    hook buffer -group pdflatex-hooks NormalKey <c-m> 'eval db'
}

hook global WinSetOption filetype=(?!pdflatex).* %{ rmhooks buffer pdflatex-hooks }
