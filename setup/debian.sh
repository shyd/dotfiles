#!/bin/bash

# Update and install basic packages
if [ `whoami` == root ]; then
    apt update -y && apt upgrade -y
    apt install zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip default-mysql-client dnsutils htop screen nload iotop pydf jnettop -y
else
    echo "Not installing any tools. I assume you already ran this script as root."
fi


# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
else
    chsh -s $(which zsh)
fi
