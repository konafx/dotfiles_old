@echo off

rem リポジトリ選択
for /f %%p in ('ghq list ^| fzf') do (
    rem リポジトリの親ディレクトリのパス取得
    for /f "DELIMS=" %%A in ('ghq root') do set repopath="%%A\%%p"
    cd /D %repopath%
    break
)

:end
