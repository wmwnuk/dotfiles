function ssh-fzf () {
  local selected_host=$(grep "Host " ~/.ssh/config | cut -b 6- | grep -v "\*" | fzf --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host} -A"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N ssh-fzf
bindkey '^\' ssh-fzf
