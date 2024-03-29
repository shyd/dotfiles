#!/bin/bash
set -e

# Update and install dependencies
if [[ -r /etc/debian_version ]] ; then
    if [ `whoami` == root ]; then
        apt update -y
        apt install wget curl git -y
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install curl git
fi

# Clone repo or update
if [[ ! -d  ~/.dotfiles ]] ; then
    git clone https://github.com/shyd/dotfiles ~/.dotfiles
fi

# Make setup executable
chmod +x ~/.dotfiles/setup/*.sh
chmod +x ~/.dotfiles/.lessfilter

# Run setup
if [[ -r /etc/debian_version ]] ; then
    ~/.dotfiles/setup/debian.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ~/.dotfiles/setup/macos.sh
fi

~/.dotfiles/setup/unix.sh
