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

set timeoutlen=500
set mouse=nv
set aw      "autowrite
set bg=dark "background
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

colo fewcolors

if $TERM =~ 'screen-256color'
    set t_so=[7m
    set t_ZH=[3m
endif
