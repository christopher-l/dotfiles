""" vim-plug
if !exists('g:GtkGuiLoaded')
  call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'kien/ctrlp.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'neomake/neomake'
  Plug 'w0ng/vim-hybrid'
  Plug 'rust-lang/rust.vim'
  Plug 'jacoborus/tender'
  Plug 'chriskempson/base16-vim'
  call plug#end()
endif

""" general
set exrc
set number
set scrolloff=1
" Highlight all columns after current textwidth
let &colorcolumn=join(map(range(1,999), '"+".v:val'), ",")
" set ttm=0
set mouse=nv
set hidden
set tw=80
set fo=crqj
set list
set lcs=tab:▸\ ,trail:·
" set autoindent
set spl=de,en
" set history=10000
set ruler
" set laststatus=2
" set backspace=indent,eol,start
" set diffopt=filler,foldcolumn:0
set foldmethod=indent
set nofoldenable
set foldnestmax=2
" set completeopt=longest,menu

""" search
" set incsearch
set smartcase
set ignorecase
" set hlsearch
" nohlsearch

""" menu
" set wildmenu
" set wildmode=longest,full
" set wildignore+=*.o,*.ali,*.gcno,*.gcda
" set wildignorecase
" set wildcharm=<Tab>

""" statusline
function! MyStatusLine()
  let status_ok = GetNeomakeStatus()
  let neomake_status_str = neomake#statusline#get(bufnr("%"), {
        \ 'format_running': '{{running_job_names}}...',
        \ 'format_loclist_ok': status_ok,
        \ 'format_loclist_unknown': '',
        \ 'format_loclist_type_E': '{{type}}:{{count}} ',
        \ 'format_loclist_type_W': '{{type}}:{{count}} ',
        \ 'format_loclist_type_I': '{{type}}:{{count}} ',
        \ })
  return "%<%f\ %h%m%r%=%-18.("
        \ . neomake_status_str
        \ . "%)\ %-14.(%l,%c%V%)\ %P"
endfunction

set statusline=%!MyStatusLine()

""" keybindings
let mapleader=","
noremap <F1> <Nop>
noremap! <F1> <Nop>
nnoremap <Leader>, <C-^>
nnoremap <Leader>. :wa<CR>:Neomake!<CR>
" nnoremap <Leader>/ :w<CR>:Neomake<CR>
nnoremap <silent> <BS> :noh<CR><ESC>
nnoremap <Leader>s :set spell!<CR>
" nnoremap <silent> <Leader>t :!termite -d "%:h"&<CR><CR>

""" theme
set termguicolors
" set bg=dark
" colorscheme base16-tomorrow

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
  autocmd FileType markdown   setlocal ts=4 sw=4 sts=4 et fo+=t spell
        \| nnoremap <buffer> <Leader>. :w<CR>:!pandoc "%" -o "%:r.pdf"<CR>
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType mail       setlocal tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType python     setlocal ts=4 sw=4 sts=4 et
  autocmd FileType rust       setlocal ts=4 sw=4 sts=4 et tw=79 fo+=t
        \| nnoremap <Leader>. :wa<CR>:Cargo<CR>
        \| nnoremap <Leader>> :wa<CR>:Cargo 
        \| nnoremap <Leader>/ :wa<CR>:sp +te\ cargo\ test<CR>G
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType matlab setlocal commentstring=%\ %s
  autocmd FileType desktop setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell
  autocmd FileType xml setlocal et ts=2 sw=2 sts=2 tw=0
  autocmd FileType dosini setlocal commentstring=#\ %s

  autocmd DirChanged * if filereadable(".exrc") | source .exrc | endif
endif

""" plugins
nnoremap <Leader>e :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRUFiles<CR>
nnoremap <Leader>c :CtrlP %:h<CR>
let g:ctrlp_reuse_window = 'help'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_match_window = 'max:99'
let g:ctrlp_follow_symlinks = 1

let g:deoplete#enable_at_startup = 1

" au FileType rust let b:neomake_enabled_makers = ['cargo']
" let g:neomake_open_list = 2
let g:neomake_tex_enabled_makers = ['rubber']
let g:neomake_rust_enabled_makers = ['cargo']
" let g:neomake_rust_cargo_command = ['test']

:command! -nargs=? Cargo :call RunCargo(<f-args>)

function! RunCargo(...)
  if a:0 == 1
    let s:cargo_command = a:1
  elseif !exists("s:cargo_command")
    let s:cargo_command = 'build'
  endif
  let g:neomake_rust_cargo_command = [s:cargo_command]
  silent Neomake cargo
  echo ' cargo ' . s:cargo_command . '...'
endfunction

function! GetNeomakeStatus() abort
  let job_name = exists("s:neomake_job_name") ? ' ' . s:neomake_job_name : ''
  let has_failed = exists("s:neomake_exit_code") && s:neomake_exit_code != 0
  if has_failed
    return job_name . ' FAILED '
  else
    return job_name . ' ✓ '
  endif
endfunction

function! PrintNeomakeStatus() abort
  let job_name = exists("s:neomake_job_name") ? ' ' . s:neomake_job_name : ''
  let has_failed = exists("s:neomake_exit_code") && s:neomake_exit_code != 0
  if has_failed
    echohl ErrorMsg
    echo job_name . ' FAILED '
    echohl None
  else
    echohl ModeMsg
    echo job_name . ' ✓ '
    echohl None
  endif
endfunction

function! MyOnNeomakeJobFinished() abort
  let context = g:neomake_hook_context
  let s:neomake_exit_code = context.jobinfo.exit_code
  let s:neomake_job_name = context.jobinfo.maker.name
  if context.jobinfo.maker.name == 'cargo' && exists("s:cargo_command")
    let s:neomake_job_name .= ' ' . s:cargo_command
  endif
  call PrintNeomakeStatus()
endfunction

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
augroup END

if exists("g:GuiLoaded") && !exists('g:GtkGuiLoaded')
  source $HOME/.config/nvim/ginit.vim
endif
