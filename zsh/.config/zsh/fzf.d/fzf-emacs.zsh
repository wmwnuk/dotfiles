function emacs-fzf () {
  local selected_session=$(tmuxifier list-sessions | fzf --query "$LBUFFER")
  if [ -n "$selected_session" ]; then
    case $selected_session in
        main)
            BUFFER="emacsclient -t -a '' -s $(whoami) ${HOME}"
    zle accept-line
            ;;
        *)
            session_dir=$(\cat "$TMUXIFIER_LAYOUT_PATH/$selected_session.session.sh" | grep session_root | cut -d'"' -f2)
            BUFFER="emacsclient -t -a '' -s ${selected_session} ${session_dir}"
    zle accept-line
            ;;
    esac
  fi
  zle reset-prompt
}
zle -N emacs-fzf
bindkey '^e' emacs-fzf
alias efzf='emacs-fzf'
