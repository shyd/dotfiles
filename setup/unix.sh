#!/bin/bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

replace_with_symlink () {
    target="$1"
    name="$2"
    source_path="$DOTFILES_DIR/$target"
    destination="$HOME/$name"

    if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$source_path" ]; then
        return
    fi

    if [ -L "$destination" ]; then
        rm "$destination"
        echo "removed symlink $name"
    fi

    if [ -e "$destination" ]; then
        echo "$name already exists, renaming"
        mv "$destination" "$destination.pre-applied-dotfiles"
    fi

    ln -s "$source_path" "$destination"
    echo "created symlink $name"
}

# Delete exsting dotfiles and create Symlinks
dotfiles=( ".zshrc" ".zshrc.local.grml" ".aliases" ".functions" ".tmux.conf" ".ideavimrc" )

# Remove the former asdf config only when it is the symlink created by this
# bootstrap; never touch a user-managed .asdfrc.
if [ "$(readlink "$HOME/.asdfrc" 2>/dev/null || true)" = "$DOTFILES_DIR/.asdfrc" ]; then
    rm "$HOME/.asdfrc"
fi

for dotfile in "${dotfiles[@]}"
do
    replace_with_symlink $dotfile $dotfile
done

mkdir -p ~/.config
replace_with_symlink ".config/nvim/init.vim" ".vimrc"
replace_with_symlink ".config/nvim" ".config/nvim"
replace_with_symlink ".config/direnv" ".config/direnv"
replace_with_symlink ".config/starship.toml" ".config/starship.toml"


cp -f "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
