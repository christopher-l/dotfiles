""" vim-plug
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'kien/ctrlp.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'mh21/errormarker.vim'
  Plug 'lervag/vimtex'
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  Plug 'roxma/nvim-completion-manager'
  Plug 'w0ng/vim-hybrid'
  Plug 'rust-lang/rust.vim'
  Plug 'albertorestifo/github.vim'
  Plug 'nlknguyen/papercolor-theme'
  Plug 'protesilaos/prot16-vim'
  Plug 'thenewvu/vim-colors-blueprint'
  Plug 'jakwings/vim-colors'
  Plug 'arcticicestudio/nord-vim'
call plug#end()

""" General
set exrc
set number
set scrolloff=1
" Highlight all columns after current textwidth
let &colorcolumn=join(map(range(1,999), '"+".v:val'), ",")
set mouse=nv
set hidden
set tw=80
set fo=crqj
set list
set lcs=tab:▸\ ,trail:·
set spl=de,en
set ruler
set foldmethod=indent
set nofoldenable
set foldnestmax=2

""" Search
set smartcase
set ignorecase

""" Keybindings
let mapleader=","
noremap <F1> <Nop>
noremap! <F1> <Nop>
nnoremap <Leader>, <C-^>
nnoremap <silent> <BS> :noh<CR><ESC>
nnoremap <Leader>s :set spell!<CR>
nnoremap <silent> <Leader>t :sp +te<CR>i
nnoremap <silent> <Leader>. :wa<CR>:RunAsync<CR>
nnoremap <Leader>> :wa<CR>:RunAsync 

""" Theme
set termguicolors
set bg=dark
colorscheme hybrid

""" Rules
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
        \| let &l:errorformat = '%f:%l-%*\d: %m,%f:%l: %m,'
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
        \| syntax spell toplevel
  autocmd FileType plaintex   setlocal ts=2 sw=2 sts=2 et fo+=t spell
  autocmd FileType markdown   setlocal ts=4 sw=4 sts=4 et fo+=t spell
        \| nnoremap <buffer> <Leader>. :w<CR>:!pandoc "%" -o "%:r.pdf"<CR>
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType mail       setlocal tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType python     setlocal ts=4 sw=4 sts=4 et
  autocmd FileType rust       setlocal ts=4 sw=4 sts=4 et tw=80 fo+=t
        \| if !exists("g:async_command") | let g:async_command = 'cargo build'
        \| endif
        \| nnoremap <buffer> <Leader>> :wa<CR>:RunAsync cargo 
        \| nnoremap <buffer> <Leader>/ :wa<CR>:sp +te\ cargo\ test<CR>G
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType matlab setlocal commentstring=%\ %s
  autocmd FileType desktop setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell
  autocmd FileType xml setlocal et ts=2 sw=2 sts=2 tw=0
  autocmd FileType dosini setlocal commentstring=#\ %s
  autocmd FileType bib setlocal et ts=2 sw=2 sts=2 commentstring=%\ %s
  autocmd FileType help setlocal nospell

  autocmd DirChanged * if filereadable(".exrc") | source .exrc | endif
endif

""" Plugins
nnoremap <Leader>e :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <Leader>c :CtrlP %:h<CR>
let g:ctrlp_reuse_window = 'help'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_match_window = 'max:99'
let g:ctrlp_follow_symlinks = 1

let g:neomake_tex_enabled_makers = ['rubber']
let g:neomake_rust_enabled_makers = ['cargo']

let g:vimtex_fold_enabled = 1
let g:tex_flavor = 'latex'
let g:vimtex_syntax_minted = [
          \ {
          \   'lang' : 'rust',
          \   'environments' : ['rustcode'],
          \   'ignored': ['rustinline'],
          \ }
\]

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

let errormarker_errortextgroup = "Error"
let errormarker_errorgroup = ""
let errormarker_warninggroup = ""

""" AsyncRun
" Trigger AutoCmds for errormarker
let g:asyncrun_auto = "make"

function! RunAsync(...)
  if a:0 == 1
    let g:async_command = a:1
  elseif !exists("g:async_command")
    let g:async_command = 'make'
  endif
  exec "AsyncRun " . g:async_command
endfunction
command! -nargs=? RunAsync :call RunAsync(<f-args>)

function! Get_asyncrun_status()
  let async_status = g:asyncrun_status
  if async_status == 'running'
    return g:async_command . ' •'
  elseif async_status == 'success'
    return g:async_command . ' ✔'
  elseif async_status == 'failure'
    return g:async_command . ' ✘'
  else
    return ''
  endif
endfunction

set statusline=%<%f\ %h%m%r%=%{Get_asyncrun_status()}\ \ \ %-14.(%l,%c%V%)\ %P

""" GUI Config
if exists("g:GuiLoaded") && !exists('g:GtkGuiLoaded')
  source $HOME/.config/nvim/ginit.vim
endif
