#!/bin/bash

# Install basic packages
#if [ `whoami` == root ]; then
    sudo apt update -y
    sudo apt install zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils htop screen nload iotop pydf cargo ripgrep fd-find tmux chafa exiftool neovim -y

    # asdf nodejs
    sudo apt install dirmngr gpg curl gawk -y
    # asdf ruby
    sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev -y
    # asdf python
    sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

    # install exa if available
    if [ $(apt-cache search --names-only ^exa$ | wc -c) -ne 0 ]; then
        sudo apt install exa -y
    fi

    #add en_US.UTF-8 to locales and rebuild them
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
    dpkg-reconfigure --frontend=noninteractive locales

    git clone https://github.com/wofr06/lesspipe.git /tmp/lesspipe.sh
    cd /tmp/lesspipe.sh
    ./configure
    sudo make install
    cd -
    rm -rf /tmp/lesspipe.sh

    sudo update-alternatives --set editor $(update-alternatives --list editor | grep nvim)
#else
#    echo "Not installing any tools via apt. I assume you already ran this script as root."
#    echo "Now running cargo..."
    cargo install bat git-delta
    #rm -rf ~/.cargo/registry
#fi


# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
elif [[ "$SHELL" == *"zsh"* ]] ; then
    echo "Skipping to set shell, zsh already is your default shell."
else
    echo "Please provide your password in order to change your default shell to zsh."
    chsh -s $(which zsh)
fi
