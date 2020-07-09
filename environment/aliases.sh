#!/bin/bash

cat <<EOF >> $HOME/.bashrc
# Folder Navigation
PS1='\u@\h:\w\%~'
alias l='ls -CF'
alias ll='ls -alhF --color=auto'
alias ls='ls --color=auto'
#alias update='sudo -- sh -c "yum update && apt upgrade"'
export HISTTIMEFORMAT='%F %T '
# alias vi='vim:colorscheme bluewery'
alias hosts='sudo vim /etc/hosts'

## DOCKER ##
alias d='docker'
alias de='docker exec -it'
alias ds='docker ps'
alias dsl='docker service ls'
alias di='docker images'
alias dip='docker image prune -a'
alias dc='docker-compose
alias dcup='docker-compose up -d'
alias dcd='docker-compose down'
alias dns='docker network ls'
alias dl='docker logs'
alias dr='docker restart'
EOF