call pathogen#infect()
filetype plugin indent on

""" general
set encoding=utf-8
set ff=unix
set ttm=0
set mouse=nv
set hidden
set autochdir
set nu
set ts=4
set sw=4
set et
set cc=80
set tw=80
set fo=crqj
set list
set lcs=tab:▸\ 
set autoindent
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/ngerman
set spl=de,en

""" search
set incsearch
set smartcase
set ignorecase
set hlsearch

""" menu
set wildmenu
set wildmode=full
set wildignore+=*.o,*.ali
set wildignorecase

""" keybindings
let mapleader=","
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
nnoremap ,, ,
nnoremap <Leader>b :ls<CR>:b 
nnoremap <Leader>w <C-W>
nnoremap <Leader>c :cd %:p:h<CR>
nnoremap <Leader>l :!pdflatex --interaction=nonstopmode %<CR>
nnoremap <silent> <Leader><ESC> :noh<CR><ESC>
nnoremap <Leader>z :let &bg = ( &bg == "dark"? "light" : "dark" )<CR>
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>f 1z=

""" theme
set bg=light
colo lucius

""" gvim
if has("gui_running")
  set lines=60 columns=120
  set guifont=Liberation\ Mono\ 8
  set guicursor+=a:blinkon0
  set guioptions-=m  " menu bar
  set guioptions-=T  " tool bar
  set guioptions+=c  " console for choices
  set guioptions-=e  " gui tabs
  nnoremap <F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  set laststatus=2
endif

""" rules
if has("autocmd")
  autocmd FileType make       setlocal ts=8 sw=8 noet
  autocmd FileType html       setlocal ts=2 sw=2 et
  autocmd FileType css        setlocal ts=2 sw=2 et
  autocmd FileType javascript setlocal ts=4 sw=4 et
  autocmd FileType c          setlocal ts=4 sw=4 noet
  autocmd FileType ada        setlocal ts=3 sw=3 et fo-=o
  autocmd FileType tex        setlocal ts=2 sw=2 et fo+=t
  autocmd FileType mail       setlocal cc=72 tw=72 fo+=t
  autocmd FileType vim        setlocal ts=2 sw=2 et
endif

""" browser
let g:netrw_list_hide='\.swp$,\.o$,\.ali$,\.swo$'

""" plugins
map <Leader>e :NERDTreeFocus<CR>
let NERDTreeIgnore=['\.swp$', '\.o$', '\.ali$', '\.swo$']
let NERDTreeMouseMode=2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") 
      \ && b:NERDTreeType == "primary") | q | endif  " close NT if last window

"let g:airline_theme='sol'
let g:airline_symbols = {}
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_section_z = '%3l,%-3c %P'
