#!/bin/sh

doas chown lanius:lanius /home/lanius/.ssh/wsl2-ssh-agent.sock
eval $(wsl2-ssh-agent)