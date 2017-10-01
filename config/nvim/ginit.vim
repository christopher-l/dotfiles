let s:fontsize=11
exec "GuiFont Fira Mono Medium:h" . s:fontsize
GuiLinespace 2

function! AdjustFontSize(delta)
  let l:font=substitute(g:GuiFont, ':h\zs\d\+', '\=eval(submatch(0)+a:delta)', '')
  exec "GuiFont " . l:font
endfunction

function! ResetFontSize()
  let l:font=substitute(g:GuiFont, ':h\zs\d\+', s:fontsize, '')
  exec "GuiFont " . l:font
endfunction

nnoremap <C-=> :call AdjustFontSize(1)<CR>
nnoremap <C-+> :call AdjustFontSize(1)<CR>
nnoremap <C--> :call AdjustFontSize(-1)<CR>
nnoremap <C-0> :call ResetFontSize()<CR>

" inoremap <MiddleMouse> <C-R>*
