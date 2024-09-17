#!/bin/bash

INSTALL=""

# Install basic packages
INSTALL+=" zsh awscli nload rar wget imagemagick vips exiftool eza bat git-delta ripgrep fd tmux htop gnu-sed chafa exiftool coreutils neovim duf btop"

# asdf plugin nodejs
INSTALL+=" gpg gawk"
# asdf ruby
INSTALL+=" openssl@1.1 readline libyaml"
# asdf python
INSTALL+=" openssl readline sqlite3 xz zlib tcl-tk"
# asdf direnv
INSTALL+=" direnv"

brew install $INSTALL

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
