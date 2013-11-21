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

""" search
set incsearch
set smartcase
set ignorecase

""" menu
set wildmenu
set wildmode=full
set wildcharm=<Tab>
set wildignore+=*.o,*.ali
set wildignorecase
noremap <Tab> :ls<CR>:b 
noremap <S-Tab> :e <Tab><C-P>

""" keybindings
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
map <Leader>c :cd %:p:h<CR>
map <Leader>ll :!pdflatex --interaction=nonstopmode %<CR>

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
  set bg=light
  colo github
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
endif

""" browser
let g:netrw_list_hide='\.swp$,\.o$,\.ali$,\.swo$,\*$'
let g:netrw_sort_sequence='[\/]$,\<core\%(\.\d\+\)\=\>,\.gpr$,\.h$,\.hpp$,\.ads$,\.c$,\.cpp$,\.adb$,\~\=\*$,*,\.obj$,\.info$,\.bak$,\~$'
map <Leader>e :Ex<CR>
