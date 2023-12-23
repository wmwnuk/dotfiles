function tk-fzf () {
  local selected_session=$(tmux list-sessions | cut -d':' -f1 | sort --ignore-case | $(__fzfcmd) --query "$LBUFFER")
  if [ -n "$selected_session" ]; then
    BUFFER="tmux kill-session -t ${selected_session}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N tk-fzf
bindkey '^k' tk-fzf
alias tk='tk-fzf'
