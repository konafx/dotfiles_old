@echo off

for /f %%i in ('ghq list -p ^| fzf') do (
  cd /d %%i
  break
)

:end
