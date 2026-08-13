#!/bin/bash
set -e

pull_if_checkout() {
    destination="$1"

    [ -d "$destination/.git" ] || return 0
    git -C "$destination" pull --ff-only
}

pull_if_checkout "$HOME/.oh-my-zsh"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/k"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/zsh-z"
pull_if_checkout "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
pull_if_checkout "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin"
pull_if_checkout "$HOME/.fzf"
pull_if_checkout "$HOME/.tmux/plugins/tpm"

if [ -x "$HOME/.fzf/install" ]; then
    "$HOME/.fzf/install" --all
fi
if command -v curl >/dev/null 2>&1; then
    curl -fsSL https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o "$HOME/.fzf-git.sh"
fi

if command -v vim >/dev/null 2>&1 && [ -f "$HOME/.vim/autoload/plug.vim" ]; then
    vim +PlugUpdate +qa
fi
if command -v nvim >/dev/null 2>&1 && [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    nvim +PlugUpdate +qa
fi
if command -v tmux >/dev/null 2>&1 && [ -x "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh" ]; then
    tmux start-server
    tmux new-session -d
    "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"
fi
