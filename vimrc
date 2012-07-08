source ~/.vim/vundle.vim
Bundle "Syntastic"
Bundle "taglist.vim"
Bundle "ragtag.vim"
map <F8> :NERDTreeToggle<CR>
map <F9> :TlistToggle<CR>
let NERDTreeDirArrows=0

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'

set mouse=nv
set aw      "autowrite
set bg=dark "background
set nu      "number
set ts=4    "tabstop
set sw=4    "shiftwidth
set et      "expandtab
set wildmenu
set pt=<F2> "pastetoggle
"set cindent

colo fewcolors
