" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
    "let g:ale_lint_on_enter=0
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
    " Python
    " flake8をLinterとして登録
    let g:ale_linters = {
      \ 'html': [],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'python': ['flake8'],
      \ 'java': ['javac', 'sbtserver'],
      \ }
    " Fixerを登録
    let g:ale_fixers = {
      \ 'python': ['autopep8', 'black', 'isort'],
      \ }
    " Pythonパスをvenv上に固定
    let g:ale_python_flake8_executable = g:python3_host_prog
    let g:ale_python_flake8_options = '-m flake8'
    let g:ale_python_autopep8_executable = g:python3_host_prog
    let g:ale_python_autopep8_options = '-m autopep8'
    let g:ale_python_isort_executable = g:python3_host_prog
    let g:ale_python_isort_options = '-m isort'
    let g:ale_python_black_executable = g:python3_host_prog
    let g:ale_python_black_options = '-m black'

    let g:mapleader = ','
    noremap <Subleader> <Nop>
    map <Space> <Subleader>
    nnoremap <Subleader>, ,
    xnoremap <Subleader>, ,

    let g:ale_sign_error = '!!'
    let g:ale_sign_warning = '=='
    let g:ale_sign_info = '--'
endfunction

" This function determines when a plugin is loaded.
"
" Possible values are:
" * 'start' (a plugin will be loaded at VimEnter event)
" * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
" * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
" <filetypes> and <excmds> can be multiple values separated by comma.
"
" This function must contain 'return "<str>"' code.
" (the argument of :return must be string literal)
function! s:loaded_on()
  return 'start'
endfunction

" Dependencies of this plugin.
" The specified dependencies are loaded after this plugin is loaded.
"
" This function must contain 'return [<repos>, ...]' code.
" (the argument of :return must be list literal, and the elements are string)
" e.g. return ['github.com/tyru/open-browser.vim']
function! s:depends()
  return []
endfunction
