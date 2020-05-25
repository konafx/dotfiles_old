# Setting fish as interactive shell
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
  exec fish
fi

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/konafx/.sdkman"
[[ -s "/home/konafx/.sdkman/bin/sdkman-init.sh" ]] && source "/home/konafx/.sdkman/bin/sdkman-init.sh"
