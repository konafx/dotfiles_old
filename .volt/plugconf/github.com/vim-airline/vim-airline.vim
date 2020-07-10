" vim:et:sw=2:ts=2

function! s:on_load_pre()
  let g:airline_statusline_ontop = 0
  let g:airline_powerline_fonts = 1
endfunction

function! s:on_load_post()
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
