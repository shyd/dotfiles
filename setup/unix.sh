#!/bin/bash
set -e

pull_or_clone () {
    echo "$2"
    git -C "$2" pull 2>/dev/null || git clone --depth 1 $1 "$2"
    echo ""
}

# Install oh-my-zsh & plugins
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
pull_or_clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
pull_or_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
pull_or_clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
pull_or_clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
pull_or_clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
pull_or_clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z
pull_or_clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
pull_or_clone https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin

# Create z file
touch ~/.z

# Install asdf and plugins
pull_or_clone https://github.com/asdf-vm/asdf.git ~/.asdf
. $HOME/.asdf/asdf.sh
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git
asdf plugin-add python

# Delete exsting dotfiles and create Symlinks
dotfiles=( ".zshrc" ".zshrc.local.grml" ".vimrc" ".vim" ".p10k.zsh" ".asdfrc" ".aliases" ".functions" ".tmux.conf" )

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
pull_or_clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
pull_or_clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
pull_or_clone https://github.com/tpope/vim-surround ~/.vim/pack/dist/start/vim-surround
pull_or_clone https://github.com/bkad/camelcasemotion ~/.vim/pack/dist/start/camelcasemotion
pull_or_clone https://github.com/justinmk/vim-sneak ~/.vim/pack/dist/start/vim-sneak

pull_or_clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
wget https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -qO ~/.fzf-git.sh

# install tmux plugins
pull_or_clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
#tmux kill-server
