#!/bin/bash

# Install oh-my-zsh & plugins
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z

# Create z file
touch ~/.z

# Install asdf and plugins
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
. $HOME/.asdf/asdf.sh
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git
asdf plugin-add python

# Delete exsting dotfiles and create Symlinks
dotfiles=( ".zshrc" ".zshrc.local.grml" ".zshrc.local" ".vimrc" ".vim" ".p10k.zsh" ".asdfrc" ".aliases" ".functions" ".tmux.conf" )

for dotfile in "${dotfiles[@]}"
do
    if [ -L ~/$dotfile ]; then
        rm ~/$dotfile
        echo "removed symlink $dotfile"
    fi

    if [ -e ~/$dotfile ]; then
        echo "$dotfile already exists, renaming"
        mv ~/$dotfile ~/$dotfile.pre-applied-dotfiles
    fi

    ln -s ~/.dotfiles/$dotfile ~/$dotfile
    echo "created symlink $dotfile"
    
done

yes | cp -f ~/.dotfiles/.gitconfig ~/.gitconfig

# Install vim themes & plugins
git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
# only install if nodejs is present
if command -v node &> /dev/null
then
    git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1 ~/.vim/pack/coc/start/coc.nvim
    vim -c "helptags ~/.vim/pack/coc/start/coc.nvim/doc/ | q"
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server