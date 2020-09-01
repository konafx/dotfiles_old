" langcode
set encoding=utf-8
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

" leaderkey
nnoremap , <Nop>
let mapleader = ","

" close window
nnoremap <silent> <Leader>q :quit<CR>

" indent 2にするマン……
if has("autocmd")
  filetype plugin on
  filetype indent on
  autocmd FileType html,xhtml         setlocal ts=2 sts=2 sw=0
  autocmd FileType markdown           setlocal ts=2 sts=2 sw=0
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

" 一致文字列のアピール
set showmatch

" 警告OFF
set belloff=all

" ステータスラインを常に表示
set laststatus=2

" 複数一致時、全一致を羅列し、共通最長文字列を補完
set wildmode=list:longest

" ハイライト
syntax on

" 背景透過
let t:is_transparent = $TRANSPARENT_TERM
if t:is_transparent
  augroup TransparentBG
    autocmd!
    autocmd Colorscheme * highlight Normal ctermbg=none
    autocmd Colorscheme * highlight NonText ctermbg=none
    autocmd Colorscheme * highlight LineNr ctermbg=none
    autocmd Colorscheme * highlight Folded ctermbg=none
    autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
  augroup END
endif

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

" 永続アンドゥ
set undofile
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"), "p")
endif
set undodir=$HOME/vim/undodir

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

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

" schema
Plug 'cocopon/iceberg.vim'

" Langs
Plug 'editorconfig/editorconfig-vim'
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
Plug 'jwalton512/vim-blade', { 'for': ['php', 'blade'] }

Plug 'bkad/CamelCaseMotion'
Plug 'alvan/vim-closetag'

" Fixer
Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Operator
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'

" Explorer
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Templater
Plug 'mattn/vim-sonictemplate'

" Search
" e.g.) maekawa -> 前川
Plug 'osyo-manga/vim-vigemo'
Plug 'rhysd/clever-f.vim'

" Replacer
Plug 'brooth/far.vim'
Plug 'lambdalisue/reword.vim'

Plug 'tpope/vim-surround'

" チートシート
Plug 'reireias/vim-cheatsheet'
" 翻訳
Plug 'skanehira/translate.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'

" Commenter
Plug 'tyru/caw.vim'

" StatusLine
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

call plug#end()
" =================================
" vim-close tab
let g:closetag_filetypes = 'html,xhtml,phtml,vue'
let g:closetag_shortcut = '>'

" CamelCaseMotion
let g:camelcasemotion_key = '<Leader>'
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

" ale
" Python
" flake8をLinterとして登録
let g:ale_linters = {
  \ 'html': [],
  \ 'css': ['stylelint'],
  \ 'javascript': ['eslint'],
  \ 'python': ['flake8'],
  \ 'java': ['javac', 'sbtserver'],
  \ 'php': ['phpcs', 'php'],
  \ }
" Fixerを登録
let g:ale_fixers = {
  \ 'python': ['autopep8', 'black', 'isort'],
  \ 'php': ['phpcbf'],
  \ }
" 保存時の自動整形
let g:ale_fix_on_save = 1
" Pythonパスをvenv上に固定
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black'
" PHP
let g:ale_php_phpcbf_standard = 'PSR2'
let g:ale_php_phpcs_standard = 'PSR2'

" let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_sign_info = '--'

" airline
let g:airline_statusline_ontop = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

" airline-themes
let g:airline_theme='papercolor'

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

" vim-operator-replace
nmap R <Plug>(operator-replace)

" vim-operator-surround
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

" NERDTree
let g:NERDTreeShowHidden=1
noremap <Leader><S-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" caw.vim
" 行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" " 行頭にコメントをトグル
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)

" fern.vim
let g:fern#default_hidden=1
" S-t: un*t*il cursor move (like *f*)
noremap <S-t> :Fern . -drawer -toggle<CR>
autocmd FileType fern setlocal nonumber

" fern-renderer-nerdfont.vim
let g:fern#renderer = 'nerdfont'

" colorscheme
set background=dark
colorscheme iceberg
