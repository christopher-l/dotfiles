call pathogen#infect()

" latex
filetype plugin indent on
"set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'

" gvim
set guicursor+=a:blinkon0
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

" general
set encoding=utf-8
set timeoutlen=500 "fix esc delay
set mouse=nv
set aw      "autowrite
"set bg=dark "background
set nu      "number
set ts=2    "tabstop
set sw=2    "shiftwidth
set et      "expandtab
set cc=80   "colorcolumn
"set tw=80   "textwidth
set wildmenu
set wildmode=longest,list
set smartcase

" keymappings
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
map <F8> :e %:p:h<CR>
map <F9> :args %<.*<CR> :la<CR>
map <F10> :args %<.*<CR>
map <F11> :s/^/--/<CR>
map <F12> :s/--//<CR>

" theme
set bg=dark
"let g:aldmeris_termcolors = "tango"
"colo aldmeris
let g:solarized_contrast = "high"
colo solarized
call togglebg#map("<F5>")

"if $TERM =~ 'screen-256color'
"    set t_so=[7m
"    set t_ZH=[3m
"endif
