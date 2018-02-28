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
  Plug 'neomake/neomake'
  Plug 'lervag/vimtex'
  Plug 'racer-rust/vim-racer'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'w0ng/vim-hybrid'
  Plug 'rust-lang/rust.vim'
  Plug 'albertorestifo/github.vim'
  Plug 'nlknguyen/papercolor-theme'
call plug#end()

""" general
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

""" search
set smartcase
set ignorecase

""" keybindings
let mapleader=","
noremap <F1> <Nop>
noremap! <F1> <Nop>
nnoremap <Leader>, <C-^>
nnoremap <Leader>. :wa<CR>:Neomake!<CR>
nnoremap <silent> <BS> :noh<CR><ESC>
nnoremap <Leader>s :set spell!<CR>
nnoremap <silent> <Leader>t :sp +te<CR>i

""" theme
set termguicolors
set bg=dark
colorscheme hybrid

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
        \| syntax spell toplevel
        \ nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType plaintex   setlocal ts=2 sw=2 sts=2 et fo+=t spell
  autocmd FileType markdown   setlocal ts=4 sw=4 sts=4 et fo+=t spell
        \| nnoremap <buffer> <Leader>. :w<CR>:!pandoc "%" -o "%:r.pdf"<CR>
        \| nnoremap <silent> <buffer> <Leader>v
        \ :!evince "%:r.pdf" &> /dev/null &<CR> :redraw!<CR>
  autocmd FileType mail       setlocal tw=72 fo+=t spell
  autocmd FileType vim        setlocal ts=2 sw=2 sts=2 et
  autocmd FileType python     setlocal ts=4 sw=4 sts=4 et
  autocmd FileType rust       setlocal ts=4 sw=4 sts=4 et tw=80 fo+=t
        \| nnoremap <buffer> <Leader>. :wa<CR>:Cargo build<CR>
        \| nnoremap <buffer> <Leader>> :wa<CR>:Cargo 
        \| nnoremap <buffer> <Leader>/ :wa<CR>:sp +te\ cargo\ test<CR>G
        \| nmap <buffer> gd <Plug>(rust-def)
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType gtkrc setlocal commentstring=#\ %s
  autocmd FileType matlab setlocal commentstring=%\ %s
  autocmd FileType desktop setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell
  autocmd FileType xml setlocal et ts=2 sw=2 sts=2 tw=0
  autocmd FileType dosini setlocal commentstring=#\ %s
  autocmd FileType bib setlocal et ts=2 sw=2 sts=2 commentstring=%\ %s

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

let g:airline#extensions#neomake#enabled = 1
let g:airline_theme = 'papercolor'

let g:neomake_tex_enabled_makers = ['rubber']
let g:neomake_rust_enabled_makers = ['cargo']

let g:tex_flavor = 'latex'
let g:vimtex_syntax_minted = [
          \ {
          \   'lang' : 'rust',
          \   'environments' : ['rustcode'],
          \   'ignored': ['rustinline'],
          \ }
\]

let g:racer_cmd = "/home/chris/.cargo/bin/racer"
let g:racer_experimental_completer = 1

""" Neomake
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

""" GUI Config
if exists("g:GuiLoaded") && !exists('g:GtkGuiLoaded')
  source $HOME/.config/nvim/ginit.vim
endif
