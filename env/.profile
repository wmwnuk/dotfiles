# Source a .bashrc if it exists:
[ "$0" = "/bin/bash" ] && [ -r ~/.bashrc ] && . ~/.bashrc

export TERMINAL=/usr/bin/kitty
export PATH=$PATH:/sbin:/usr/sbin:$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin:$HOME/.magento-cloud/bin:$HOME/Applications:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.local/podman/bin:$HOME/.config/emacs/bin:$HOME/.tmux/plugins/tmuxifier/bin:$HOME/go/bin:/opt/qtools/bin

export SVDIR=~/.local/service

if [ ! -f "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
    $HOME/.local/bin/start-ssh-agent.sh
fi
if [ -s "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
    . $XDG_RUNTIME_DIR/ssh-agent-env
fi

export NIXPKGS_ALLOW_UNFREE=1
[ -e /nix/var/nix/profiles/default ] && export XDG_DATA_DIRS=$XDG_DATA_DIRS:/nix/var/nix/profiles/default/share
export QT_QPA_PLATFORMTHEME=qt5ct
export ZDOTDIR=$HOME/.config/zsh
export LS_OPTIONS="--color=tty"
export EDITOR="vim"
export VISUAL=$EDITOR
export BAT_THEME="Enki-Tokyo-Night"
export PAGER="less -R"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux/layouts"
export TMUXIFIER_TEMPLATE_PATH="$HOME/.tmux/templates"

[ -r /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ $TERM != 'dumb' ] && which tmuxifier >/dev/null && eval "$(tmuxifier init -)"

xset b off &>/dev/null

eval $(wsl2-ssh-agent)
