eval "$(zoxide init zsh)"

\builtin unalias zix &>/dev/null || \builtin true
function zix() { 
    if [[ -d "$@" ]]; then
        __zoxide_z "$@" >/dev/null
    elif [[ -d "$PWD/$@" ]]; then
        __zoxide_z "$@" >/dev/null
    else
        __zoxide_zi "$@" >/dev/null || __zoxide_z "$@"
    fi
}
