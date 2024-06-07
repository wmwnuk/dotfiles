#!/usr/bin/env bash

alias emacs="emacsclient -t -a ''" e=emacs
alias md="mkdir"
alias tarview="tar -tvf"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias den=warden
# alias ssh="TERM=xterm-256color ssh.exe"
alias map-vnc="ssh davyjones -L 9901:localhost:5901"

gbdefault() {
  git remote show origin | sed -n '/HEAD branch/s/.*: //p'
}

gnewb() {
    git checkout "$(gbdefault)" && git pull && git checkout -b "$1"
}
