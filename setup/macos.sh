#!/bin/bash

brew install zsh awscli nload rar wget imagemagick vips exiftool exa bat git-delta ripgrep fd tmux htop gnu-sed

# asdf plugin nodejs
brew install gpg gawk
# asdf ruby
brew install openssl@1.1 readline libyaml
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# asdf python
brew install openssl readline sqlite3 xz zlib tcl-tk
