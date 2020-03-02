" vim:et:sw=2:ts=2

function! s:on_load_pre()
  let g:airline_powerline_fonts = 1
endfunction

function! s:on_load_post()
  let g:airline#extensions#tabline#enabled = 1
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
