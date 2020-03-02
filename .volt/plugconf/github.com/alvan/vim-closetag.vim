" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
endfunction

function! s:on_load_post()
  let g:closetag_filetypes = 'html,xhtml,phtml,vue'
  let g:closetag_shortcut = '>'
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
