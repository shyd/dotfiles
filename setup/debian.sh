#!/bin/bash
set -e

sudo apt update -y

install_if_available() {
    local pkg="$1"
    if apt-cache show "$pkg" >/dev/null 2>&1; then
        sudo apt install -y "$pkg"
    else
        echo "Skipping unavailable package: $pkg"
    fi
}

# Core packages for Ubuntu and Raspberry Pi OS/Debian.
packages=(
    zsh net-tools vim wget curl git tree rsync openssh-client zip dnsutils htop
    screen nload iotop pydf cargo ripgrep tmux chafa exiftool neovim btop
    dirmngr gpg gawk autoconf bison build-essential libssl-dev libyaml-dev
    libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev
    libdb-dev uuid-dev make libbz2-dev libsqlite3-dev llvm libncursesw5-dev
    xz-utils tk-dev libxml2-dev libxmlsec1-dev liblzma-dev direnv xclip
    wl-clipboard
)

for pkg in "${packages[@]}"; do
    install_if_available "$pkg"
done

# fd package differs by distro.
install_if_available fd-find
install_if_available fd

# add en_US.UTF-8 to locales and rebuild them
sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo dpkg-reconfigure --frontend=noninteractive locales

git clone https://github.com/wofr06/lesspipe.git /tmp/lesspipe.sh
cd /tmp/lesspipe.sh
./configure
sudo make install
cd -
rm -rf /tmp/lesspipe.sh

if update-alternatives --list editor 2>/dev/null | grep -q nvim; then
    sudo update-alternatives --set editor "$(update-alternatives --list editor | grep nvim | head -n1)"
fi

cargo install bat git-delta eza || true

# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
elif [[ "$SHELL" == *"zsh"* ]] ; then
    echo "Skipping to set shell, zsh already is your default shell."
else
    echo "Set zsh as default shell"
    sudo chsh -s "$(which zsh)" "$USER"
    echo "Done."
fi
