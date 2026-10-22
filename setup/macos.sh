#!/bin/bash

INSTALL=""

# Install basic packages
INSTALL+=" zsh awscli nload rar wget imagemagick vips exiftool eza bat git-delta ripgrep fd tmux htop gnu-sed chafa coreutils neovim duf btop starship tio direnv"

brew install $INSTALL

# Nerd Font variants for terminal, editor, and prompt symbols. Menlo is
# included with macOS, so it does not need a separate installation.
brew install --cask \
    font-lilex-nerd-font \
    font-jetbrains-mono-nerd-font \
    font-meslo-lg-nerd-font
