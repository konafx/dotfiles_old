set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

if !1 | finish | endif

set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
filetype on

" 全角幅文字の表示 {{{
set ambiwidth=double
" }}}

" インデント関係 {{{
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
" }}}

" leaderkey {{{
nnoremap , <Nop>
let mapleader = ","
" }}}

" map alias {{{
" window & tab
set termwinkey=<C-g>
nnoremap <silent> gr <Cmd>tabprevious<CR>
tnoremap <C-g>gr <C-g>gT

" 水平移動
noremap H ^
noremap L g_

" 1文字貼り付け防止
noremap x "_x

" インデントしても選択領域を保持
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" `*`検索の初回移動無効
nnoremap <silent><expr> * v:count ? '*'
\ : ':sil exe "keepj norm! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'
" }}}

" ファイルタイプごとの設定 {{{
filetype plugin on
filetype indent on
augroup FileTyper
  autocmd!
  autocmd FileType html,xhtml         setlocal ts=2 sts=2 sw=0
  autocmd FileType markdown           setlocal ts=2 sts=2 sw=0
  autocmd FileType css,sass,scss      setlocal ts=2 sts=2 sw=0
  autocmd FileType javascript         setlocal ts=2 sts=2 sw=0
  autocmd FileType vue                setlocal ts=2 sts=2 sw=0
  autocmd FileType vim                setlocal ts=2 sts=2 sw=0
  autocmd FileType python             setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END
" }}}

" コメントアウト行後の改行時にコメントアウトを入れない {{{
augroup DisableInsertNextlineComment
  autocmd!
  autocmd FileType *                  setlocal formatoptions-=ro
augroup END
" }}}

" cache {{{
" 恐れるな
set nobackup
set noswapfile
" }}}

" visual {{{
" 行番号表示
set number

" 一致文字列のアピール
set showmatch

" 警告OFF
set belloff=all

" marker folding
set foldmethod=marker

" ステータスラインを常に表示
set laststatus=2

" 特殊表示 {{{
" 色々わかりやすくするやつ
set list
set listchars=tab:\▸\-,trail:-,extends:»,precedes:«
" ↑の付随: Grey rbg(95, 95, 135)にする
hi NonText    ctermfg=59
hi SpecialKey ctermfg=59
" }}}

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
" }}}

" search {{{
" 大文字小文字の区別をしない
set ignorecase
" 大文字で検索したときは大文字のみ検索
set smartcase
"  検索が末尾に届いたら、先頭に戻る
set wrapscan
" hylight
set hlsearch
" clear hylight
nmap <Esc><Esc> <Cmd>nohlsearch<CR>
" 複数一致時、全一致を羅列し、共通最長文字列を補完
set wildmode=list:longest
" }}}

" json processer {{{
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
      let l:arg = "."
  else
      let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction
" }}}

" WSLでyank-to-clipboard {{{
if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * <Cmd>call system('clip.exe', @")
  augroup END
endif
" }}}

" git grep {{{
function! s:gitgrep(query)
  let l:current_grep = &grepprg " 前回の設定値の保存
  setlocal grepprg=git\ grep\ -I\ --line-number
  execute 'silent grep! ' . a:query
  let &grepprg = l:current_grep
  redraw!
endfunction

command! -nargs=? Ggrep call s:gitgrep(<f-args>)
" }}}

" use rg {{{
if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif
" }}}

" jvgrep {{{
function! s:jvgrep(query)
  let l:current_grep = &grepprg
  setlocal grepprg=jvgrep
  execute 'silent grep! ' . a:query ' ./*'
  let &grepprg = l:current_grep
  redraw!
endfunction

command! -nargs=? Jvgrep call s:jvgrep(<f-args>)
" }}}

" quickfixgrep {{{
augroup quickfixgrep
  autocmd!
  autocmd QuickFixCmdPost make,*grep* cwindow
augroup END
" }}}

" vim-plug {{{1
call plug#begin()
Plug 'tyru/restart.vim'
Plug 'tpope/vim-sensible'

Plug 'vim-jp/vimdoc-ja'

if has('python')
  " Fades inactive buffers
  Plug 'TaDaa/vimade'
endif

Plug 'mattn/vimtweak'

" Plug 'lighttiger2505/sqls.vim'
" Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

" colorschema
Plug 'cocopon/iceberg.vim'
Plug 'machakann/vim-colorscheme-snowtrek'
Plug 'koirand/tokyo-metro.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'cideM/yui'
Plug 'jaredgorski/spacecamp'
Plug 'franbach/miramare'
Plug 'bignimbus/pop-punk.vim'
Plug 'atelierbram/Base2Tone-vim'
Plug 'reedes/vim-colors-pencil'
Plug 'ulwlu/elly.vim'
Plug 'kato-k/vim-colorscheme-settings'

" Snippets
Plug 'henricattoire/aergia'
Plug 'mattn/vim-sonictemplate'

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
Plug 'wellle/tmux-complete.vim', { 'for': 'tmux' }
Plug 'chrisbra/csv.vim'

" pdv requirements
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv', { 'for': 'php' }
Plug 'jwalton512/vim-blade', { 'for': ['php', 'blade'] }
" Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
" Plug 'elythyr/phpactor-mappings'

Plug 'bkad/CamelCaseMotion'

Plug 'dhruvasagar/vim-table-mode'

" Fuzzy Finder
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'ctrlpvim/ctrlp.vim'
" ctrlp extensions
Plug 'mattn/ctrlp-ghq'
Plug 'hara/ctrlp-colorscheme'
Plug 'kshenoy/vim-ctrlp-args'
Plug 'jeetsukumaran/vim-buffergator'


Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Operator
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'

" Git
Plug 'lambdalisue/gina.vim'

" GitHub
Plug 'skanehira/gh.vim'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Search
" e.g.) maekawa -> 前川
Plug 'osyo-manga/vim-vigemo'
Plug 'rhysd/clever-f.vim'

" Replacer
Plug 'brooth/far.vim'
Plug 'lambdalisue/reword.vim'

Plug 'tpope/vim-surround'

Plug 'mattn/vim-lexiv'

" チートシート
Plug 'reireias/vim-cheatsheet'
" 翻訳
Plug 'skanehira/translate.vim'

" vim-gist requirements
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'

Plug 'skanehira/code2img.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'

" Commenter
Plug 'tyru/caw.vim'

" StatusLine
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Explorer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" startup
Plug 'mhinz/vim-startify'

call plug#end()
" 1}}}

" view {{{
syntax on
" }}}

" vim-close tab {{{
let g:closetag_filetypes = 'html,xhtml,phtml,vue'
let g:closetag_shortcut = '>'
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['typescript'] = { 'type' : 'typescript/tsc' }
let g:quickrun_config['typescript/tsc'] = {
\   'exec': ['%c --target esnext --module commonjs %o %s', 'node %s:r.js'],
\   'tempfile': '%{tempname()}.ts',
\   'hook/sweep/files': ['%S:p:r.js'],
\ }
" }}}

" CamelCaseMotion {{{
let g:camelcasemotion_key = '<Space>'
" }}}

" airline {{{
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
" }}}

" vim-devicon {{{
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
" }}}

" nerdfont.vim {{{
let g:nerdfont#path#extension#customs = {}
let g:nerdfont#path#extension#customs['vue'] = ''
" }}}

" vim-vue {{{
syntax sync fromstart "syntax
" }}}

" cheatsheet {{{
" g:cheatsheet#cheat_file
let g:cheatsheet#float_window = 0
" }}}

" vim-ref {{{
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
" }}}

" clever-f {{{
" dont allow overwrite |t|, |T|
let g:clever_f_not_overwrites_standard_mappings=1
nmap f <Plug>(clever-f-f)
xmap f <Plug>(clever-f-f)
omap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
xmap F <Plug>(clever-f-F)
omap F <Plug>(clever-f-F)
" }}}

" vim-operator-replace {{{
nmap R <Plug>(operator-replace)
" }}}

" vim-operator-surround {{{
map <silent> sa <Plug>(operator-surround-append)
map <silent> sd <Plug>(operator-surround-delete)
map <silent> sr <Plug>(operator-surround-replace)
" }}}

" caw.vim {{{
" 行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" " 行頭にコメントをトグル
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)
" }}}

" gina.vim {{{
set diffopt+=vertical
noremap <silent> <C-s> <Cmd>Gina status -s<CR>
" }}}

" fern.vim {{{
let g:fern#default_hidden=1
" S-t: un*t*il cursor move (like *f*)
" noremap sf <Cmd>Fern %:h<CR>
noremap <S-t> <Cmd>Fern . -drawer -reveal=% -toggle<CR>
autocmd FileType fern setlocal nonumber
" }}}

" fern-renderer-nerdfont.vim {{{
let g:fern#renderer = 'nerdfont'
" }}}

" phpactor {{{
" autocmd FileType php setlocal omnifunc=phpactor#Complete
" }}}

" vim-lsp {{{
let g:lsp_diagnostics_echo_cursor = 1
nnoremap <expr> <silent> <C-]> execute(':LspDefinition') =~ "not supported" ? "\<C-]>" : ":echo<cr>"
" }}}

" vim-clap {{{
let g:clap_layout = { 'relative': 'editor' }
" }}}

" ctrlp {{{
" ctrlp-ghq
let g:ctrlp_ghq_actions = [
  \ {"label": "Fern", "action": "Fern", "path": 1},
  \ {"label": "Open", "action": "e", "path": 1},
  \ {"label": "Look", "action": "!ghq look", "path": 0},
  \]
let ctrlp_ghq_default_action = 'lcd'
let g:ctrlp_ghq_cache_enabled = 0
" }}}

" buffergator {{{
let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy="N"
" {{{
" Original code was posted to vim-jp.slack.com
" author: https://github.com/kuuote
" function! s:buffergator_filter() abort
"   let lines = copy(s:lines)
"   let text = getcmdline()
"   call filter(lines, {_, val -> val =~? text})
"   setlocal modifiable
"   silent 1,$delete _
"   silent 0put=lines
"   $d
"   setlocal nomodifiable
"   call cursor('$', 1)
"   redraw
" endfunction
" 
" function! s:buffergator_cmd() abort
"   autocmd FuzzyBuffgator CmdlineChanged * call s:buffergator_filter()
"   call input('buffergator: ')
" endfunction
" 
" augroup FuzzyBuffgator
"   autocmd!
"   autocmd CmdlineLeave * autocmd! FuzzyBuffgator CmdlineChanged
" augroup END
" 
" function! s:read_buffergator_buffer(timer) abort
"   let s:lines = getline(1, '$')
" endfunction
" 
" function! s:buffergator_init() abort
"   call timer_start(0, function('s:read_buffergator_buffer'))
" endfunction
" 
" function! s:buffergator_enter() abort
"   let line = getline('.')
"   let bufnum = matchstr(getline('.'), '^.*\[\zs.*\ze\]')
"   execute 'bdelete | wincmd w | '. 'buffer ' . trim(bufnum)
" endfunction
" 
" autocmd FileType buffergator call s:buffergator_init()
" autocmd FileType buffergator noremap <silent> <buffer> <Leader>/ :<C-u>call <SID>buffergator_cmd()<CR>
" autocmd FileType buffergator noremap <silent> <buffer> m :<C-u>call <SID>buffergator_enter()<CR>
" }}}
" }}}

" vim-gist {{{
let g:gist_extmap = {
  \ ".md": "markdown"
  \ }
" }}}

" colorscheme {{{
" let g:colorschemes_settings#rc_file_path = expand("~/vimfiles/colorrc.vim")
let g:colorschemes_settings#use_default_colorschemes = v:false
set background=dark
colorscheme iceberg
" }}}

" LOCAL VIMRC {{{
" 環境依存になりがちな設定
if has('win32') || has('win64')
  let s:vimhome = expand("$HOME/vimfiles")
elseif has('unix')
  let s:vimhome = expand("$HOME/.vim")
endif
" }}}

" 永続アンドゥ {{{
set undofile
if !isdirectory(s:vimhome .. "/undodir")
  call mkdir(s:vimhome .. "/undodir", "p")
endif
execute "set undodir=" .. s:vimhome .. "/undodir"
" }}}

" cheatsheet {{{
let g:cheatsheet#cheat_file = s:vimhome .. "/cheatsheet/vim.md"
" augroup cheat_filetype
"   autocmd!
"   let cheatsheet#cheat_dir = s:vimhome .. "/cheatsheet"
"   autocmd FileType * let g:cheatsheet#cheat_file = cheatsheet#cheat_dir .. "/vim.md"
" augroup END
" }}}

" Restart.vim {{{
command!
  \ -bar
  \ RestartWithSession
  \ let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'
  \ | Restart
" }}}

" Startify {{{
let g:startify_bookmarks = [
  \ {'c': s:vimhome .. "/vimrc"},
  \ {'v': s:vimhome .. "/gvimrc"},
  \ s:vimhome,
  \ ]
let g:startify_commands = [
  \ ':help reference',
  \ {'n': ['Notes', 'Fern $HOME/Workspace/0_notes']},
  \ {'g': ['Ghq', 'CtrlPGhq']},
  \ {'sc': ['ColorScheme', 'CtrlPColorscheme']},
  \ {'sl': ['Sessions', 'SLoad']},
  \ ]
" }}}

" pdv {{{
let g:pdv_template_dir = s:vimhome .. "plugged/pdv/templates"
nnoremap <Leader><C-p> :call pdv#DocumentWithSnip()<CR>
" }}}

" MAPPING {{{1
" find file
nnoremap <silent> <Leader>f <Cmd>CtrlP<CR>
" open filer
nnoremap <silent> <Leader>d <Cmd>Fern %:h<CR>
" open filer (project)
nnoremap <silent> <Leader>D <Cmd>Fern . -reveal=%<CR>
" find buffer
nnoremap <silent> <Leader>b <Cmd>BuffergatorOpen<CR>
" quickfix
" quickfix toggler function {{{3
function! ToggleQuickfix()
  let l:nr = winnr('$')
  cwindow
  let l:nr2 = winnr('$')
  if l:nr == l:nr2
    cclose
  endif
endfunction
" 3}}}
nnoremap <silent> <Leader>q <Cmd>call ToggleQuickfix()<CR>
" save
nnoremap <silent> <Leader>w <Cmd>w<CR>

" [git] {{{2
nnoremap [git] <Nop>
nmap <Leader>g [git]

nnoremap <silent> [git]f <Cmd>Clap git_files<CR>
nnoremap <silent> [git]s <Cmd>Gina status -s<CR>
nnoremap <silent> [git]b <Cmd>Gina branch<CR>
nnoremap <silent> [git]l <Cmd>Gina log<CR>
" 2}}}

" [tab] {{{2
nnoremap [tab] <Nop>
nmap t [tab]

nnoremap <silent> [tab]n <Cmd>tabnext<CR>
nnoremap <silent> [tab]p <Cmd>tabprevious<CR>
nnoremap <silent> [tab]e <Cmd>tabedit<CR>
nnoremap <silent> [tab]c <Cmd>tabclose<CR>
nnoremap <silent> [tab]o <Cmd>tabonly<CR>
" 2}}}
" 1}}}

" colorscheme-settings {{{
let g:colorschemes_settings#rc_file_path = s:vimhome .. "/colorrc.vim"
if filereadable(g:colorschemes_settings#rc_file_path)
  execute "source" g:colorschemes_settings#rc_file_path
endif
" }}}

" CREDENTIALS {{{
if filereadable(s:vimhome .. "/credentials.vim")
  exec "source" s:vimhome .. "/credentials.vim"
endif
" }}}

