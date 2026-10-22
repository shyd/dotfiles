#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pull_or_clone() {
    url="$1"
    destination="$2"

    if [ -d "$destination/.git" ]; then
        git -C "$destination" pull --ff-only
    else
        git clone --depth 1 "$url" "$destination"
    fi
}

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

pull_or_clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
pull_or_clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
pull_or_clone https://github.com/zsh-users/zsh-completions "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
pull_or_clone https://github.com/supercrabtree/k "$HOME/.oh-my-zsh/custom/plugins/k"
pull_or_clone https://github.com/agkozak/zsh-z "$HOME/.oh-my-zsh/custom/plugins/zsh-z"
pull_or_clone https://github.com/Aloxaf/fzf-tab "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
pull_or_clone https://github.com/unixorn/fzf-zsh-plugin.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin"

touch "$HOME/.z"
DOTFILES_DIR="$DOTFILES_DIR" "$DOTFILES_DIR/setup/unix.sh"

install_vim_plugins() {
    editor="$1"
    plug_path="$2"

    command -v "$editor" >/dev/null 2>&1 || return 0
    curl -fLo "$plug_path" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "$editor" +PlugInstall +qa
}

install_vim_plugins vim "$HOME/.vim/autoload/plug.vim"
install_vim_plugins nvim "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"

pull_or_clone https://github.com/junegunn/fzf.git "$HOME/.fzf"
"$HOME/.fzf/install" --all
curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$HOME/.fzf-git.sh"

pull_or_clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
tmux start-server
tmux new-session -d
"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
