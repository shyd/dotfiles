#!/bin/bash

# Install basic packages
if [ `whoami` == root ]; then
    apt update -y
    apt install zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils htop screen nload iotop pydf jnettop -y

    # install exa if available
    if [ $(apt-cache search --names-only ^exa$ | wc -c) -ne 0 ]; then
        apt install exa
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
