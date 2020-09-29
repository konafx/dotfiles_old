" メニューバー非表示
set guioptions -=m
" ツールバー非表示
set guioptions -=T
" スクロルバー非表示
set guioptions -=r
set guioptions -=R
set guioptions -=l
set guioptions -=L
set guioptions -=b

"font
set guifont=Cica:h12

" window size
set lines=40
set columns=120

" maximized
autocmd GUIEnter * simalt ~x
