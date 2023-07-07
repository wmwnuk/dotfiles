# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# It seems zshenv doesn't get sourced at all here on SUSE, so let's source it to have our $PATH
source $HOME/.zshenv

export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
SAVEHIST=20000
setopt append_history
setopt inc_append_history # add history immediately after typing a command

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
# zsh_add_file "zsh-vim-mode"
bindkey -e
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"
zsh_add_file "zsh-completions"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Vterm
zsh_add_file "vterm.zsh"

# FZF
zsh_add_file "fzf.zsh"
compinit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line

# Speedy keys
xset r rate 210 40 2>/dev/null

source "$HOME/.aliases"

# override fzf keybinding
donormalexitmoron() {exit}
zle -N donormalexitmoron

tmuxkillserver() {tmux kill-server}
zle -N tmuxkillserver

bindkey  "^[K"    tmuxkillserver

bindkey  "^D"     donormalexitmoron

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[1~"  beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[4~"  end-of-line
bindkey  "^[[3~"  delete-char

case $TERM in
    linux)
        [[ ! -f ~/.config/zsh/.p10k.linux.zsh ]] || source ~/.config/zsh/.p10k.linux.zsh
        ;;
    *)
        [[ ! -f ~/.config/zsh/.p10k.xterm.zsh ]] || source ~/.config/zsh/.p10k.xterm.zsh
        ;;
esac

[ "$INSIDE_EMACS" != '' ] && source "$HOME/.emacs.sh"
