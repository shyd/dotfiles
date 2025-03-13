#!/bin/bash
set -e

pull_or_clone () {
    echo "$2"
    git -C "$2" pull 2>/dev/null || git clone --depth 1 $1 "$2"
    echo ""
}

replace_with_symlink () {
    target="$1"
    name="$2"
    if [ -L ~/$name ]; then
        rm ~/$name
        echo "removed symlink $name"
    fi

    if [ -e ~/$name ]; then
        echo "$name already exists, renaming"
        mv ~/$name ~/$name.pre-applied-dotfiles
    fi

    ln -s ~/.dotfiles/$target ~/$name
    echo "created symlink $name"
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
#pull_or_clone https://github.com/asdf-vm/asdf.git ~/.asdf
#. $HOME/.asdf/asdf.sh
#asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
#asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
#asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git
#asdf plugin-add python
#asdf plugin-add direnv

# Delete exsting dotfiles and create Symlinks
dotfiles=( ".zshrc" ".zshrc.local.grml" ".p10k.zsh" ".asdfrc" ".aliases" ".functions" ".tmux.conf" ".ideavimrc" )

for dotfile in "${dotfiles[@]}"
do
    replace_with_symlink $dotfile $dotfile
done

mkdir -p ~/.config
replace_with_symlink ".config/nvim/init.vim" ".vimrc"
replace_with_symlink ".config/nvim" ".config/nvim"
replace_with_symlink ".config/direnv" ".config/direnv"


yes | cp -f ~/.dotfiles/.gitconfig ~/.gitconfig

# Install vim themes & plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qa
vim +PlugUpdate +qa
nvim +PlugInstall +qa
nvim +PlugUpdate +qa

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
