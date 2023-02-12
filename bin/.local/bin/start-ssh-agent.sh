#!/bin/bash

# case $DESKTOP_SESSION in
#     i3)
        if ! pgrep -x ssh-agent -u $(id -u) >/dev/null; then
            # This sets SSH_AUTH_SOCK and SSH_AGENT_PID variables
            eval "$(ssh-agent -s)"
            export SSH_AUTH_SOCK SSH_AGENT_PID
            echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK;export SSH_AGENT_PID=$SSH_AGENT_PID" > "$XDG_RUNTIME_DIR/ssh-agent-env"
        fi
        # ;;
# esac
