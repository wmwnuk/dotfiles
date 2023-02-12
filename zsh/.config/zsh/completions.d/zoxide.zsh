eval "$(zoxide init zsh)"

\builtin unalias zix &>/dev/null || \builtin true
function zix() { 
    if [[ -z "$@" ]]; then
        __zoxide_z "$@"
    elif [[ -d "$PWD/$@" ]]; then
        __zoxide_z "$@"
    else
        __zoxide_zi "$@" > /dev/null || __zoxide_z "$@"
    fi
}
