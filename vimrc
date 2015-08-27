call pathogen#infect()
filetype plugin indent on

""" general
set encoding=utf-8
set ff=unix
set ttm=0
set mouse=nv
set hidden
"set autochdir
set nu
set ts=4
set sw=4
set sts=4
set et
set so=3
set cc=80
set tw=72
set fo=crqj
set list
set lcs=tab:▸\ ,trail:_
set autoindent
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/ngerman
set spl=de,en
set history=10000
set winwidth=84
set winheight=30
set cursorline
set laststatus=2
set exrc

""" search
set incsearch
set smartcase
set ignorecase
set hlsearch
nohlsearch

""" menu
set wildmenu
set wildmode=full
set wildignore+=*.o,*.ali,*.gcno,*.gcda
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
nnoremap <Leader>, <C-^>
nnoremap <silent> <BS> :noh<CR><ESC>
nnoremap <Leader>z :let &bg = ( &bg == "dark"? "light" : "dark" )<CR>
nnoremap <Leader>s :set spell!<CR>
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>x :source $MYVIMRC<CR>
nnoremap <C-Up> :call AdjustFontSize(1)<CR>:echo &guifont<CR>
nnoremap <C-Down> :call AdjustFontSize(-1)<CR>:echo &guifont<CR>
nnoremap <Leader>` g`"
nnoremap <Leader>y :SyntasticToggleMode<CR>
nnoremap <Leader>d :call ToggleDocstringMode()<CR>
" nnoremap <Leader>. :w\|!./%<CR>
nnoremap <Leader>r :e %:r.

""" theme
" set bg=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
let g:airline_theme='hybrid'

""" gvim
if has("gui_running")
  colorscheme hybrid-light
  "set lines=60 columns=120
  set guifont=Source\ Code\ Pro\ 10
  set guicursor+=a:blinkon0
  set guioptions-=m  " menu bar
  set guioptions-=T  " tool bar
  set guioptions+=c  " console for choices
  set guioptions-=e  " gui tabs
  nnoremap <F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
endif

""" rules
if has("autocmd")
  autocmd FileType make       setlocal ts=8 sw=8 noet
  autocmd FileType html       setlocal ts=2 sw=2 sts=2 et
  autocmd FileType css        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType javascript setlocal ts=2 sw=2 sts=2 et
  autocmd FileType c          setlocal ts=4 sw=4 noet
  autocmd FileType ada        setlocal ts=3 sw=3 sts=3 et fo-=o
        \ makeprg=make
        \| nnoremap <Leader>. :make!<CR>
        \| nnoremap <Leader>/ :!./run_tests<CR>
  autocmd FileType tex        setlocal ts=2 sw=2 sts=2 et fo+=t spell
        \| nnoremap <buffer> <Leader>. :!pdflatex -interaction nonstopmode
        \ -output-directory "%:h" "%"<CR>
  autocmd FileType mail       setlocal cc=72 tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType python     setlocal ts=4 sw=4 sts=4 et
  autocmd FileType rust       setlocal ts=4 sw=4 sts=4 et
        \| nnoremap <Leader>. :!cargo run<CR>
endif

""" browser
let g:netrw_list_hide='\.swp$,\.o$,\.ali$,\.swo$,\.pyc$'

""" plugins
nnoremap <Leader>e :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <Leader>c :CtrlP %:h<CR>
"let g:ctrlp_match_window = 'max:50,results:50'
let g:ctrlp_reuse_window = 'help'

map <Leader>t :NERDTreeFind<CR>
let NERDTreeIgnore=['\.swp$', '\.o$', '\.ali$', '\.swo$', '\.pyc$']
let NERDTreeMouseMode=2
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
      \ && b:NERDTreeType == "primary") | q | endif  " close NT if last window
autocmd bufenter * call UpdateNerdTree()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z = '%3l,%-3c %P'

""" functions
function! AdjustFontSize(amount)
  let &guifont=substitute(&guifont,'\zs\d\+','\=eval(submatch(0)+a:amount)','')
endfunction

function! ToggleDocstringMode()
    if exists('b:docstringmode') && b:docstringmode
        echo 'disable docstringmode'
        let b:docstringmode = 0
        setlocal fo-=ta
        setlocal tw=79
        setlocal cc=80
        setlocal nospell
        norm m`
        %s/\v^(\s*)(\S.{-1,})\s+"""$/\1\2\r\1"""/e
        norm ``
    else
        echo 'enable docstringmode'
        let b:docstringmode = 1
        setlocal fo+=ta
        setlocal tw=72
        setlocal cc=73
        setlocal spell
    endif
endfunction

function! UpdateNerdTree()
  if (&bt == "" && exists("t:NERDTreeBufName")
      \ && bufwinnr(t:NERDTreeBufName) != -1)
    NERDTreeFind
    norm 
  endif
endfunction
