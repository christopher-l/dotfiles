let s:default_fontsize = 11
let s:fontsize = s:default_fontsize
let s:font = "Fira Mono Medium"
exec "GuiFont " . s:font . ":h" . s:fontsize
GuiLinespace 4

function! AdjustFontSize(delta)
  let s:fontsize += a:delta
  exec "GuiFont " . s:font . ":h" . s:fontsize
endfunction

function! ResetFontSize()
  let s:fontsize = s:default_fontsize
  exec "GuiFont " . s:font . ":h" . s:fontsize
endfunction

nnoremap <C-=> :call AdjustFontSize(1)<CR>
nnoremap <C-+> :call AdjustFontSize(1)<CR>
nnoremap <C--> :call AdjustFontSize(-1)<CR>
nnoremap <C-0> :call ResetFontSize()<CR>

set bg=dark
colorscheme base16-tomorrow-night
hi SpellBad guifg=#cc6666

set laststatus=0
set noruler
set statusline=
set noshowmode

nnoremap <Leader>e :GonvimFuzzyFiles<CR>
nnoremap <Leader>b :GonvimFuzzyBuffers<CR>
" nnoremap <Leader>c :GonvimFuzzyAg<CR>
nnoremap <Leader>g :GonvimFuzzyBLines<CR>
