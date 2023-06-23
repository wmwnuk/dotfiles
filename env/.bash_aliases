#!/usr/bin/env bash

alias emacs="emacsclient -t -a '' -s $(basename ${TMUXIFIER_SESSION_ROOT:-"$HOME"})" e=emacs
alias md="mkdir"
alias tarview="tar -tvf"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
