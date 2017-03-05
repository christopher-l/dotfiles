""" vim-plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kien/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neomake/neomake'
call plug#end()

""" general
set number
set scrolloff=1
set colorcolumn=80
" set ttm=0
" set mouse=nv
" set hidden
" set tw=72
" set fo=crqj
set list
set lcs=tab:▸\ ,trail:_
" set autoindent
set spl=de,en
" set history=10000
set ruler
" set laststatus=2
" set backspace=indent,eol,start
" set diffopt=filler,foldcolumn:0
" set foldmethod=indent
" set nofoldenable
" set completeopt=longest,menu

" """ search
" set incsearch
set smartcase
set ignorecase
" set hlsearch
" nohlsearch

" """ menu
" set wildmenu
" set wildmode=longest,full
" set wildignore+=*.o,*.ali,*.gcno,*.gcda
" set wildignorecase
" set wildcharm=<Tab>

""" keybindings
let mapleader=","
nnoremap <Leader>, <C-^>
nnoremap <Leader>. :w<CR>:Neomake<CR>
nnoremap <silent> <BS> :noh<CR><ESC>
nnoremap <Leader>s :set spell!<CR>
nnoremap <silent> <Leader>t :!termite -d "%:h"&<CR><CR>

""" theme
colorscheme github-custom

""" rules
if has("autocmd")
  autocmd FileType make       setlocal ts=8 sw=8 noet
  autocmd FileType cmake      setlocal ts=2 sw=2 et
  autocmd FileType html       setlocal ts=2 sw=2 sts=2 et
  autocmd FileType text       setlocal ts=2 sw=2 sts=2 et spell
  autocmd FileType css        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType javascript setlocal ts=2 sw=2 sts=2 et
  autocmd FileType json       setlocal ts=2 sw=2 sts=2 et
  autocmd FileType c          setlocal ts=4 sw=4 et
  autocmd FileType ada        setlocal ts=3 sw=3 sts=3 et fo-=o
  autocmd FileType tex        setlocal ts=2 sw=2 sts=2 et fo+=t spell
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType plaintex   setlocal ts=2 sw=2 sts=2 et fo+=t spell
  autocmd FileType markdown   setlocal ts=2 sw=2 sts=2 et fo+=t spell
        \| nnoremap <buffer> <Leader>. :w<CR>:!pandoc "%" -o "%:r.pdf"<CR>
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType mail       setlocal cc=72 tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType python     setlocal ts=4 sw=4 sts=4 et
  autocmd FileType rust       setlocal ts=4 sw=4 sts=4 et
        \| nnoremap <Leader>. :!cargo run<CR>
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType matlab setlocal commentstring=%\ %s
endif

""" plugins
nnoremap <Leader>e :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <Leader>c :CtrlP %:h<CR>
let g:ctrlp_reuse_window = 'help'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_match_window = 'max:99'

let g:neomake_tex_enabled_makers = ['rubber']