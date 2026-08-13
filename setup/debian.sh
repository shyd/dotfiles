#!/bin/bash

INSTALL=""

sudo apt update -y

# Install basic packages
INSTALL+=" zsh net-tools vim wget curl git tree rsync openssh-client zip dnsutils htop nload iotop pydf cargo build-essential less ripgrep fd-find tmux chafa exiftool duf btop starship tio direnv"

# Neovim is optional: on Ubuntu 22.04 it is in universe, while Vim 8+ is the
# supported editor baseline on every target system.
if apt-cache show neovim >/dev/null 2>&1; then
    INSTALL+=" neovim"
fi

sudo apt install -y $INSTALL

#add en_US.UTF-8 to locales and rebuild them
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales

if command -v nvim >/dev/null 2>&1; then
    nvim_editor="$(update-alternatives --list editor | grep -m 1 nvim || true)"
    if [ -n "$nvim_editor" ]; then
        sudo update-alternatives --set editor "$nvim_editor"
    fi
fi

cargo install bat git-delta eza
#rm -rf ~/.cargo/registry


# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
elif [[ "$SHELL" == *"zsh"* ]] ; then
    echo "Skipping to set shell, zsh already is your default shell."
else
    echo "Set zsh as default shell"
    sudo chsh -s $(which zsh) $USER
    echo "Done."
fi
