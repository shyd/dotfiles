#!/bin/bash

INSTALL=""

# Install basic packages
INSTALL+=" zsh awscli nload rar wget imagemagick vips exiftool eza bat git-delta ripgrep fd tmux htop gnu-sed chafa coreutils neovim duf btop starship tio direnv"

brew install $INSTALL
