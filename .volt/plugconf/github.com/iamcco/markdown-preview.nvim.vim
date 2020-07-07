" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
  call mkdp#util#install()
  let g:mkdp_browser = 'wsl-open'
endfunction

function! s:loaded_on()
  return 'filetype=markdown'
endfunction

function! s:depends()
  return []
endfunction
