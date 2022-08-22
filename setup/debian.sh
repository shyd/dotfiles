#!/bin/bash

# Install basic packages
if [ `whoami` == root ]; then
    apt update -y
    apt install zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils htop screen nload iotop pydf jnettop -y

    # asdf nodejs
    apt install dirmngr gpg curl gawk -y
    # asdf ruby
    apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev -y
    # asdf python
    apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

    # install exa if available
    if [ $(apt-cache search --names-only ^exa$ | wc -c) -ne 0 ]; then
        apt install exa -y
    fi
else
    echo "Not installing any tools. I assume you already ran this script as root."
fi


# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
elif [[ "$SHELL" == *"zsh"* ]] ; then
    echo "Skipping to set shell, zsh already is your default shell."
else
    echo "Please provide your password in order to change your deafult shell to zsh."
    chsh -s $(which zsh)
fi
