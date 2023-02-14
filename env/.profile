# Source a .bashrc if it exists:
[ "$0" = "/bin/bash" ] && [ -r ~/.bashrc ] && . ~/.bashrc

export TERMINAL=/usr/bin/kitty
export PATH=$PATH:/sbin:/usr/sbin:$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin:$HOME/.magento-cloud/bin:$HOME/Applications:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.local/podman/bin

export SVDIR=~/.local/service

if [ ! -f /run/.containerenv ]; then
    if [ ! -f "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
        $HOME/.local/bin/start-ssh-agent.sh
    fi
    if [ -s "$XDG_RUNTIME_DIR/ssh-agent-env" ]; then
        . $XDG_RUNTIME_DIR/ssh-agent-env
    fi
fi

export NIXPKGS_ALLOW_UNFREE=1
[ -e /nix/var/nix/profiles/default ] && export XDG_DATA_DIRS=$XDG_DATA_DIRS:/nix/var/nix/profiles/default/share
export QT_QPA_PLATFORMTHEME=qt5ct
export ZDOTDIR=$HOME/.config/zsh
export LS_OPTIONS="--color=tty"
export EDITOR="/usr/bin/nvim"
export VISUAL=$EDITOR
export BAT_THEME="Enki-Tokyo-Night"
export PAGER="less -R"

# nnn config
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_PLUG="p:$HOME/.config/nnn/plugins/preview-tui;f:$HOME/.config/nnn/plugins/fzopen"

[ -r /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

xhost +si:localuser:$USER > /dev/null
