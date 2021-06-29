#!/bin/bash

# Update and install basic packages
if [ `whoami` == root ]; then
    apt update -y && apt upgrade -y
    apt install zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils htop screen nload iotop pydf jnettop -y
else
    echo "Not installing any tools. I assume you already ran this script as root."
fi


# Set default shell
if [ -f /.dockerenv ]; then
    echo "Set default shell manually, we are running inside a container.";
else
    chsh -s $(which zsh)
fi
