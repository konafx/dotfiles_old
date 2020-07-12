" langcode
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
filetype on

" ## tab
" tabToSpace
set expandtab

" 4 spaces are tab
set tabstop=4

" Tab押下→space何個
" 0→tabstopの値を参照
set softtabstop=0

" インデントに使う空白数
set shiftwidth=4

" 天才的インデントマン！！！
set smartindent

" インデント大切に守るマン！！！
set autoindent

" 色々わかりやすくするやつ
set list listchars=tab:\▸\-,trail:-,extends:»,precedes:«

" ↑の付随: Grey rbg(95, 95, 135)にする
hi NonText    ctermfg=59
hi SpecialKey ctermfg=59

" indent 2にするマン……
if has("autocmd")
  filetype plugin on
  filetype indent on
  autocmd FileType html,xhtml         setlocal ts=2 sts=2 sw=0
  autocmd FileType javascript         setlocal ts=2 sts=2 sw=0
  autocmd FileType vue                setlocal ts=2 sts=2 sw=0
  autocmd FileType vim                setlocal ts=2 sts=2 sw=0
  autocmd FileType python             setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
endif

" ## cache
" 恐れるな
set nobackup
set noswapfile

" ## view
" 行番号表示
set number

" 視覚的アラート
set visualbell

" 一致文字列のアピール
set showmatch

" ステータスラインを常に表示
set laststatus=2

" ステータスラインの表示
" air-lineで上書きされるけど
"set statusline=%<                           " shorted-position
"set statusline+=%f\                         " file [space]
"set statusline+=%m%r%h                      " flag(mod, readonly, help)
"set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=  " Git-branch-name stop
"set statusline+=%-14.(%l,%c,%v%)            " LEFT: #(line, col-b, col-vir)
"set statusline+=\ \[ENC=%{&fileencoding}]%P " fileenc current-position

" 複数一致時、全一致を羅列し、共通最長文字列を補完
set wildmode=list:longest

" ハイライト
syntax on

" ## search
" 大文字小文字の区別をしない
set ignorecase
" 大文字で検索したときは大文字のみ検索
set smartcase
"  検索が末尾に届いたら、先頭に戻る
set wrapscan
" hylight
set hlsearch
" clear hylight
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" python_venv_path
if isdirectory(expand($PYENV_ROOT))
  let g:python3_host_prog = expand("$PYENV_ROOT/versions/vim/bin/python")
endif

" json processer
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
      let l:arg = "."
  else
      let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction

" project vimrc
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<aflie>:p:h'))
  autocmd BufReadPre .vimrc.local setfiletype=vim
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" WSLでyank-to-clipboard
if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif

" =================================
" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'

" Fades inactive buffers
Plug 'TaDaa/vimade'

Plug 'tobyS/vmustache'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'ap/vim-css-color'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'typescript'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for' : 'vue' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'pixelneo/vim-python-docstring', { 'for': 'python' }
Plug 'tobyS/pdv', { 'for': 'php' }
Plug 'wellle/tmux-complete.vim', { 'for': 'tmux' }

Plug 'bkad/CamelCaseMotion'
Plug 'alvan/vim-closetag'


" syntax and fix
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'

" file tree manager
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-mapping-project-top.vim'
Plug 'lambdalisue/fern-renderer-devicons.vim'

" Git-plugin
Plug 'lambdalisue/gina.vim'

Plug 'mattn/vim-sonictemplate'

" search
" e.g.) maekawa -> 前川
Plug 'osyo-manga/vim-vigemo'
Plug 'rhysd/clever-f.vim'

" replace
Plug 'brooth/far.vim'
Plug 'lambdalisue/reword.vim'

Plug 'tpope/vim-surround'

Plug 'reireias/vim-cheatsheet'
Plug 'ryanoasis/vim-devicons'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" =================================
" vim-close tab
let g:closetag_filetypes = 'html,xhtml,phtml,vue'
let g:closetag_shortcut = '>'

" CamelCaseMotion
" let g:camelcasemotion_key = '<leader>'
map <silent> w <Plug>CamelCaseMotion_w

" ale
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

" airline-themes
let g:airline_theme='papercolor'

" fern.vim
" show hidden files
let g:fern#default_hidden=1
noremap <S-t> :Fern . -drawer -toggle<CR>

" vim-sonictemplate
let g:sonictemplate_vim_template_dir = expand('~/.vim/sonictemplate')

" vim-devicon
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
" アイコン入力方法 : `[Ctrl+V]` > `[u]` > `e905`
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['vue'] = '42B983'

" vim-vue
syntax sync fromstart "syntax

" cheatsheet
let g:cheatsheet#cheat_file = expand('~/.dotfiles/cheatsheet/vim.md')
let g:cheatsheet#float_window = 0

" vim-ref
let g:ref_source_webdict_sites = {
\   'wikipedia': {
\     'url': 'http://ja.wikipedia.org/wiki/%s'
\   },
\   'weblio': {
\     'url': 'https://ejje.weblio.jp/content/%s'
\   },
\ }
function! g:ref_source_webdict_sites.weblio.filter(output)
  return join(split(a:output, "\n")[18 :], "\n")
endfunction


" clever-f
" dont allow overwrite |t|, |T|
let g:clever_f_not_overwrites_standard_mappings=1
nmap f <Plug>(clever-f-f)
xmap f <Plug>(clever-f-f)
omap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
xmap F <Plug>(clever-f-F)
omap F <Plug>(clever-f-F)

" pdv
let g:pdv_template_dir = $HOME ."/.vim/pack/volt/opt/github.com_tobyS_pdv/templates"
nnoremap <buffer> <C-p> :call pdv#DocumentCurrentLine()<CR>

" fern-renderer-devicons
let g:fern#renderer = "devicons"

" vim-operator-replace
nmap R <Plug>(operator-replace)

" vim-operator-surround
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

