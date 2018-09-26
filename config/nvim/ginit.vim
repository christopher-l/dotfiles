set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait9999999999999

let s:default_fontsize = 12
let s:fontsize = s:default_fontsize
let s:font = "Source Code Pro, Source Han Sans Jp Medium"

function! SetFont() abort
  if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', s:font . ' ' . s:fontsize)
  else
    exec "GuiFont " . s:font . ":h" . s:fontsize
  endif
endfunction

call SetFont()

function! AdjustFontSize(delta)
  let s:fontsize += a:delta
  call SetFont()
endfunction

function! ResetFontSize()
  let s:fontsize = s:default_fontsize
  call SetFont()
endfunction

nnoremap <C-=> :call AdjustFontSize(1)<CR>
nnoremap <C-+> :call AdjustFontSize(1)<CR>
nnoremap <C--> :call AdjustFontSize(-1)<CR>
nnoremap <C-0> :call ResetFontSize()<CR>

noremap <F9> :call rpcnotify(1, 'Gui', 'Command', 'ToggleSidebar')<CR>
