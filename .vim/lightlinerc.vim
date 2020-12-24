scriptencoding utf-8

" enable tabline of lightline
if has('gui_running')
  set guioptions-=e
endif

let g:lightline = {
  \ 'colorscheme': 'iceberg',
  \ }

let g:lightline.active = {
  \ 'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \ 'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ }

let g:lightline.inactive = {
  \ 'left': [ [ 'filename' ] ],
  \ 'right': [ [ 'lineinfo' ],
  \            [ 'percent' ] ]
  \ }

let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ 'relativepath' ] ]
  \ }

let g:lightline.component = {
  \ 'filetype': '%{&ft==#"fern"?"":&ft==#""?"no ft":&ft}',
  \ 'fileencoding': '%{&ft==#"fern"?"":&fenc==#""?&enc:&fenc}',
  \ 'fileformat': '%{&ft==#"fern"?"":&ff}',
  \ }

let g:lightline.component_visible_condition = {
  \ 'filetype': '&ft!=#"fern"',
  \ 'fileencoding': '&ft!=#"fern"',
  \ 'fileformat': '&ft!=#"fern"'
  \ }

let g:lightline.component_function = {
  \ 'mode': 'Mode',
  \ 'filename': 'Filename',
  \ 'gitbranch': 'GitBranch'
  \ }

function! Mode() abort
  return &ft=~#'help\|fern' ? &ft->toupper() : lightline#mode()
endfunction

function! Filename() abort
  if &ft =~# 'fern'
    let fri = fern#fri#parse(expand('%f'))
    if fri.authority =~# '^drawer'
      return ''
    endif
    let abspath = fri.path->substitute('file:///', '', '')
    return abspath->fnamemodify(':p:gs?/?\\?:h')
  endif
  let _ = expand('%f')->pathshorten()
  return _ !=# '' ?_ : '[No Name]'
endfunction

function! GitBranch() abort
  return get(g:, 'loaded_gina', 0) ? gina#component#repo#branch()->pathshorten() : ''
endfunction
