function ollama-fzf () {
  local selected_model=$(ollama list | awk 'NR>1{print $1}' | $(__fzfcmd) --query "$LBUFFER")
  if [ -n "$selected_model" ]; then
    BUFFER="ollama run ${selected_model}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N ollama-fzf
bindkey '^o' ollama-fzf
