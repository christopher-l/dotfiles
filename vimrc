call pathogen#infect()

""" latex
filetype plugin indent on
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'

""" gvim
set guicursor+=a:blinkon0
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

""" general
set encoding=utf-8
"set timeoutlen=500 "fix esc delay
set ttm=0
set mouse=nv
set aw      "autowrite
set nu      "number
set ts=2    "tabstop
set sw=2    "shiftwidth
set et      "expandtab
set cc=80   "colorcolumn
"set tw=80   "textwidth

""" search
set incsearch
set smartcase
set ignorecase
"set hlsearch
"nnoremap <ESC> :noh<CR><ESC>

""" menu
set wildmenu
set wildmode=longest,list

""" folding
nnoremap <space> za
set foldmethod=indent
set foldlevel=99
"set foldminlines=10
"set foldnestmax=1

""" keybindings
nmap w <C-W>
nmap h <C-W>h
nmap j <C-W>j
nmap k <C-W>k
nmap l <C-W>l
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 

""" theme
set bg=dark
let g:solarized_contrast = "high"
colo solarized

""" plugins
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0

nmap <Leader>e :NERDTreeToggle<CR>
nmap e :NERDTreeFocus<CR>
let NERDTreeMouseMode=3
