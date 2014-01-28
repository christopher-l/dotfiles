call pathogen#infect()

""" general
filetype plugin indent on
set encoding=utf-8
set ff=unix
set ttm=0
set mouse=nv
set hidden
set autochdir
set nu      "number
set ts=4    "tabstop
set sw=4    "shiftwidth
set et      "expandtab
set cc=80   "colorcolumn
set tw=80   "textwidth
set fo=crqj
"set so=10   "scrolloff
set list
set lcs=tab:▸\ 
set autoindent
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/ngerman

""" search
set incsearch
set smartcase
set ignorecase
set hlsearch

""" menu
set wildmenu
set wildmode=full
set wildcharm=<Tab>
set wildignore+=*.o,*.ali
set wildignorecase
noremap <Leader><Tab> :ls<CR>:b 
noremap <S-Tab> :e <Tab><C-P>

""" keybindings
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap <C-Left> <C-W>h
nmap <C-Down> <C-W>j
nmap <C-Up> <C-W>k
nmap <C-Right> <C-W>l
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
map <Leader>c :cd %:p:h<CR>
map <Leader>ll :!pdflatex --interaction=nonstopmode %<CR>
noremap <F4> :set hlsearch! hlsearch?<CR>
nnoremap <silent> <S-ESC> :noh<CR><ESC>

""" theme
set bg=dark
colo molokai

""" gvim
if has("gui_running")
  set lines=60 columns=120
  set guifont=Hermit\ 8
  set guicursor+=a:blinkon0
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions+=c  "use console for simple choices
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
  nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
  "set bg=light
  colo solarized
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
let g:netrw_list_hide='\.swp$,\.o$,\.ali$,\.swo$,\*$'
let g:netrw_sort_sequence='[\/]$,\<core\%(\.\d\+\)\=\>,\.gpr$,\.h$,\.hpp$,\.ads$,\.c$,\.cpp$,\.adb$,\~\=\*$,*,\.obj$,\.info$,\.bak$,\~$'
"map <Leader>e :Ex<CR>

""" plugins
map <Leader>e :NERDTreeFocus<CR>
let NERDTreeIgnore=['\.swp$', '\.o$', '\.ali$', '\.swo$', '\*$']
let NERDTreeMouseMode=2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif "close NT if last window

"let g:airline_theme='jellybeans'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_section_z = '%3l,%-3c %P'
