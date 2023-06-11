#!/usr/bin/env bash

if which distrobox-list >/dev/null 2>&1; then
    selected_session=$(distrobox-list | awk 'NR>=2 {print $3}' | fzf --query "$LBUFFER")

    if [ -n "$selected_session" ]; then
        distrobox-enter $selected_session
    fi
else
    distrobox-host-exec bash -l
fi
