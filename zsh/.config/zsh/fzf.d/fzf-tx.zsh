function tx-fzf () {
  local selected_session=$(tmuxifier list-sessions | $(__fzfcmd) --query "$LBUFFER")
  if [ -n "$selected_session" ]; then
    BUFFER="tmuxifier load-session ${selected_session}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N tx-fzf
bindkey '^x' tx-fzf
alias tx='tx-fzf'
