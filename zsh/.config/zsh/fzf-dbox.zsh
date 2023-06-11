function dbox-fzf () {
    if which distrobox-list >/dev/null; then
        local selected_session=$(distrobox-list | awk 'NR>=2 {print $3}' | fzf --query "$LBUFFER")
        if [ -n "$selected_session" ]; then
            BUFFER="distrobox-enter ${selected_session}"
            zle accept-line
        fi
    else
        BUFFER="distrobox-host-exec bash -l"
        zle accept-line
    fi
    zle reset-prompt
}
zle -N dbox-fzf
bindkey '^]' dbox-fzf
alias dbox='dbox-fzf'
