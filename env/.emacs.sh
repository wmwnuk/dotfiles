#!/usr/bin/env sh

export EDITOR="emacsclient -s $(basename $PWD)"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"

alias emacs="$EDITOR" e=emacs
