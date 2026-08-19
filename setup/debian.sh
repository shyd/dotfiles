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
sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo dpkg-reconfigure --frontend=noninteractive locales

if command -v nvim >/dev/null 2>&1; then
    nvim_editor="$(update-alternatives --list editor | grep -m 1 nvim || true)"
    if [ -n "$nvim_editor" ]; then
        sudo update-alternatives --set editor "$nvim_editor"
    fi
fi

cargo install bat git-delta

install_eza() {
    case "$(uname -m)" in
        x86_64) eza_target="x86_64-unknown-linux-musl" ;;
        aarch64 | arm64) eza_target="aarch64-unknown-linux-gnu" ;;
        armv7l | armv6l) eza_target="arm-unknown-linux-gnueabihf" ;;
        *)
            echo "Skipping eza: unsupported architecture $(uname -m)"
            return 0
            ;;
    esac

    eza_temp_dir="$(mktemp -d)"
    curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${eza_target}.tar.gz" \
        -o "$eza_temp_dir/eza.tar.gz"
    tar -xzf "$eza_temp_dir/eza.tar.gz" -C "$eza_temp_dir"
    install -Dm755 "$eza_temp_dir/./eza" "$HOME/.local/bin/eza"
    rm -rf "$eza_temp_dir"
}

install_eza
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
