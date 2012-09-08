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
        hi Normal       ctermfg=LightGray ctermbg=none
        hi NonText      ctermfg=DarkGray  ctermbg=none

        hi Statement    ctermfg=none      ctermbg=none cterm=bold      term=bold
        hi Comment      ctermfg=LightBlue ctermbg=none cterm=italic    term=none
        hi Constant     ctermfg=Red       ctermbg=none
        hi Identifier   ctermfg=Green     ctermbg=none cterm=bold      term=bold
        hi Type         ctermfg=Green     ctermbg=none
        hi Folded       ctermfg=Green     ctermbg=none cterm=underline term=none
        hi Special      ctermfg=none      ctermbg=none cterm=bold      term=bold
        hi PreProc      ctermfg=LightGray ctermbg=none cterm=bold      term=bold
        hi Scrollbar    ctermfg=Blue      ctermbg=none
        hi Cursor       ctermfg=white     ctermbg=none
        hi ErrorMsg     ctermfg=Red       ctermbg=none cterm=bold      term=bold
        hi WarningMsg   ctermfg=Yellow    ctermbg=none
        hi VertSplit    ctermfg=White     ctermbg=none
        hi Directory    ctermfg=Cyan      ctermbg=none
        hi Visual       ctermfg=White     ctermbg=DarkGray cterm=none term=none
        hi Title        ctermfg=White     ctermbg=none

        hi StatusLine   ctermfg=White     ctermbg=Black cterm=bold,underline term=bold 
        hi StatusLineNC ctermfg=Gray      ctermbg=Black cterm=bold,underline term=bold 
        hi LineNr       ctermfg=Gray      ctermbg=none

else
        hi Normal       ctermfg=black     ctermbg=none
        hi NonText      ctermfg=DarkGray  ctermbg=none

        hi Statement    ctermfg=none      ctermbg=none cterm=bold      term=bold
        hi Comment      ctermfg=LightBlue ctermbg=none cterm=none      term=none
        hi Constant     ctermfg=DarkRed   ctermbg=none
        hi Identifier   ctermfg=Green     ctermbg=none cterm=bold      term=bold
        hi Type         ctermfg=DarkGreen ctermbg=none
        hi Folded       ctermfg=DarkGreen ctermbg=none cterm=underline term=none
        hi Special      ctermfg=none      ctermbg=none cterm=bold      term=bold
        hi PreProc      ctermfg=none      ctermbg=none cterm=bold      term=bold
        hi Scrollbar    ctermfg=Blue      ctermbg=none
        hi Cursor       ctermfg=white     ctermbg=none
        hi ErrorMsg     ctermfg=Red       ctermbg=none cterm=bold      term=bold
        hi WarningMsg   ctermfg=Yellow    ctermbg=none
        hi VertSplit    ctermfg=White     ctermbg=none
        hi Directory    ctermfg=Cyan      ctermbg=none
        hi Visual       ctermfg=White     ctermbg=DarkGray cterm=none term=none
        hi Title        ctermfg=White     ctermbg=none

        hi StatusLine   ctermfg=White     ctermbg=Black cterm=bold,underline term=bold 
        hi StatusLineNC ctermfg=DarkGray  ctermbg=Black cterm=bold,underline term=bold 
        hi LineNr       ctermfg=gray      ctermbg=none
endif

if $TERM != 'rxvt-unicode-256color'
    set t_so=[7m
    set t_ZH=[3m
endif
