#!/bin/bash

# Install oh-my-zsh & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z

# Create z file
touch ~/.z

# Delete exsting dotfiles and create Symlinks
dotfiles=( "zshrc" "zshrc.local.grml" "zshrc.local" "vimrc" "vim" "p10k.zsh" )

for dotfile in "${dotfiles[@]}"
do
    file=".$dotfile"
    if [ -L ~/$file ]; then
        rm ~/$file
        echo "removed symlink $file"
    fi

    if [ -e ~/$file ]; then
        echo "$file already exists, renaming"
        mv ~/$file ~/$file.pre-applied-dotfiles
    fi

    ln -s ~/.dotfiles/$dotfile ~/$file
    echo "created symlink $file"
    
done
