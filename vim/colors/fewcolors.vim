" Vim color file
" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

"set background=dark     "or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="fewcolors"

if &background =~ 'dark'
        hi Normal       ctermfg=LightGray guifg=#EEEEEC ctermbg=none guibg=Black
        hi NonText      ctermfg=DarkGray  guifg=DarkGray  ctermbg=none

        hi Statement    ctermfg=none      guifg=White     ctermbg=none cterm=bold      term=bold gui=bold
        hi Comment      ctermfg=LightBlue guifg=#34e2e2   ctermbg=none cterm=italic    term=none gui=italic
        hi Constant     ctermfg=Red       guifg=#ef2929   ctermbg=none cterm=none
        hi Identifier   ctermfg=Green     guifg=#8ae234   ctermbg=none cterm=bold      term=bold gui=bold
        hi Type         ctermfg=Green     guifg=#8ae234   ctermbg=none cterm=none                gui=none
        hi Folded       ctermfg=Green     guifg=#8ae234   ctermbg=none cterm=underline term=none guibg=Black
        hi Special      ctermfg=none      guifg=White     ctermbg=none cterm=bold      term=bold gui=bold
        hi PreProc      ctermfg=LightGray guifg=LightGray ctermbg=none cterm=bold      term=bold gui=bold
        hi Scrollbar    ctermfg=Blue      guifg=Blue      ctermbg=none
        hi Cursor       ctermfg=white     guifg=Black     ctermbg=none guibg=White
        hi ErrorMsg     ctermfg=Red                       ctermbg=none cterm=bold      term=bold gui=bold
        hi WarningMsg   ctermfg=Yellow    guifg=Yellow    ctermbg=none
        hi VertSplit    ctermfg=White     guifg=Black     ctermbg=none guibg=gray
        hi Directory    ctermfg=Cyan      guifg=Cyan      ctermbg=none
        hi Visual       ctermfg=White     guifg=#303030   ctermbg=DarkGray guibg=White cterm=reverse term=none
        hi Title        ctermfg=White     guifg=White     ctermbg=none

        hi StatusLine   ctermfg=White     guifg=White     ctermbg=Black cterm=bold,underline term=bold  gui=bold
        hi StatusLineNC ctermfg=Gray      guifg=Gray      ctermbg=Black cterm=bold,underline term=bold  gui=bold
        hi LineNr       ctermfg=Gray      guifg=Gray      ctermbg=none

else
        hi Normal       ctermfg=black     guifg=black     ctermbg=none
        hi NonText      ctermfg=DarkGray  guifg=DarkGray  ctermbg=none

        hi Statement    ctermfg=none      guifg=Black     ctermbg=none cterm=bold      term=bold gui=bold
        hi Comment      ctermfg=LightBlue guifg=#3465A4   ctermbg=none cterm=none      term=none gui=italic
        hi Constant     ctermfg=DarkRed   guifg=#CC0000   ctermbg=none
        hi Identifier   ctermfg=DarkCyan  guifg=DarkCyan  ctermbg=none cterm=none      term=bold gui=none
        hi Type         ctermfg=DarkGreen guifg=#4E9A06   ctermbg=none                           gui=none
        hi Folded       ctermfg=DarkGreen guifg=#4E9A06   ctermbg=none cterm=underline term=none gui=none
        hi Special      ctermfg=Black     guifg=Black     ctermbg=none cterm=none      term=bold gui=none
        hi PreProc      ctermfg=Black     guifg=Black     ctermbg=none cterm=bold      term=bold gui=bold
        hi Scrollbar    ctermfg=Blue      guifg=Blue      ctermbg=none
        hi Cursor       ctermfg=white     guifg=white     ctermbg=none
        hi ErrorMsg     ctermfg=Red                       ctermbg=none cterm=bold      term=bold gui=bold
        hi WarningMsg   ctermfg=Yellow    guifg=Yellow    ctermbg=none
        hi VertSplit    ctermfg=White     guifg=White     ctermbg=none
        hi Directory    ctermfg=Cyan      guifg=Cyan      ctermbg=none
        hi Visual       ctermfg=White     guifg=White     ctermbg=DarkGray cterm=none  term=none
        hi Title        ctermfg=Black     guifg=Black     ctermbg=none cterm=bold      term=bold gui=bold

        hi StatusLine   ctermfg=Black     guifg=Black     ctermbg=White cterm=bold,underline term=bold  gui=bold
        hi StatusLineNC ctermfg=DarkGray  guifg=DarkGray  ctermbg=Black cterm=bold,underline term=bold  gui=bold
        hi LineNr       ctermfg=gray      guifg=gray      ctermbg=none
endif

if $TERM != 'rxvt-unicode-256color'
    set t_so=[7m
    set t_ZH=[3m
endif
