# Setting fish as interactive shell
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
  exec fish
fi

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
