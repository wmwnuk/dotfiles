#!/bin/sh

mkdir -p /tmp/ssh

ln -s $SSH_AUTH_SOCK /tmp/ssh/agent
