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
set lcs=tab:▸\ ,trail:_
set autoindent
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/ngerman
set spl=de,en
set history=1000

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
set wildcharm=<Tab>

""" keybindings
let mapleader=","
set pastetoggle=<F2>
noremap <F1> 
noremap! <F1> 
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap ,, ,
"nnoremap <Leader>b :ls<CR>:b 
"nnoremap <Leader>v :e %:.:h/<Tab><Left>
"nnoremap <Leader>c :e %:.<Tab>
nnoremap <Leader>l :!pdflatex --interaction=nonstopmode %<CR>
nnoremap <silent> <Leader><ESC> :noh<CR><ESC>
nnoremap <Leader>zz :let &bg = ( &bg == "dark"? "light" : "dark" )<CR>
nnoremap <Leader>zc :set cursorline!<CR>
nnoremap <Leader>w :set wrap!<CR>
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>x :source $MYVIMRC<CR>
nnoremap <C-Up> :call AdjustFontSize(1)<CR>:echo &guifont<CR>
nnoremap <C-Down> :call AdjustFontSize(-1)<CR>:echo &guifont<CR>
nnoremap <Enter> o<Esc>k
nnoremap <S-Enter> O<Esc>j

""" theme
set bg=light
colo lucius

""" gvim
if has("gui_running")
  "set lines=60 columns=120
  set guifont=Fira\ Mono\ 8
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
  autocmd FileType tex        setlocal ts=2 sw=2 et fo+=t indk=
  autocmd FileType mail       setlocal cc=72 tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 et
  autocmd FileType python     setlocal ts=2 sw=2 et
endif

""" browser
let g:netrw_list_hide='\.swp$,\.o$,\.ali$,\.swo$,\.pyc$'

""" plugins
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

map <Leader>e :NERDTreeFocus<CR>
let NERDTreeIgnore=['\.swp$', '\.o$', '\.ali$', '\.swo$', '\.pyc$']
let NERDTreeMouseMode=2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
      \ && b:NERDTreeType == "primary") | q | endif  " close NT if last window

"let g:airline_theme='sol'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_section_z = '%3l,%-3c %P'

"let Tlist_Use_Right_Window=1
"let Tlist_Exit_OnlyWindow=1
"nnoremap <Leader>t :TlistToggle<CR>


""" functions
function! AdjustFontSize(amount)
  let &guifont=substitute(&guifont,'\zs\d\+','\=eval(submatch(0)+a:amount)','')
endfunction
