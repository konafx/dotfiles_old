" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
endfunction

function! s:on_load_post()
  let g:cheatsheet#cheat_file = expand('~/.dotfiles/cheatsheet/vim.md')
  let g:cheatsheet#float_window = 0
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
