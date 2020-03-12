" langcode
set fenc=utf-8
filetype on

" ## tab
" tabToSpace
set expandtab

" 4 spaces are tab
set tabstop=4

" input tab, insert 4 spaces
set softtabstop=4

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
  autocmd FileType vim,html,xhtml,javascript,vue setlocal tabstop=2 softtabstop=2 shiftwidth=2 "markup lang
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
set statusline=%<                           " shorted-position
set statusline+=%f\                         " file [space]
set statusline+=%m%r%h                      " flag(mod, readonly, help)
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=  " Git-branch-name stop
set statusline+=%-14.(%l,%c,%v%)            " LEFT: #(line, col-b, col-vir)
set statusline+=\ \[ENC=%{&fileencoding}]%P " fileenc current-position

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
