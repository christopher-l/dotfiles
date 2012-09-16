source ~/.vim/vundle.vim
Bundle "Syntastic"
Bundle "taglist.vim"
Bundle "ragtag.vim"
"map <F8> :NERDTreeToggle<CR>
map <F9> :TlistToggle<CR>
let NERDTreeDirArrows=0

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'

set lines=45 columns=90
set guicursor+=a:blinkon0
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

set timeoutlen=500
set mouse=nv
set aw      "autowrite
"set bg=dark "background
set nu      "number
set ts=4    "tabstop
set sw=4    "shiftwidth
set et      "expandtab
set wildmenu
set wildmode=longest,list
set smartcase
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
map <F3> :e %<.ads<CR>
map <F4> :e %<.adb<CR>
map <F8> :e %:p:h<CR>
map <F11> :s/^/--/<CR>
map <F12> :s/--//<CR>

colo fewcolors

"if $TERM =~ 'screen-256color'
"    set t_so=[7m
"    set t_ZH=[3m
"endif
