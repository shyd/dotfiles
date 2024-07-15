#!/bin/bash

INSTALL=""

sudo apt update -y

# Install basic packages
INSTALL+=" zsh zplug net-tools vim zsh wget curl git tree rsync openssh-client zip dnsutils htop screen nload iotop pydf cargo ripgrep fd-find tmux chafa exiftool neovim duf btop"

# asdf nodejs
INSTALL+=" dirmngr gpg curl gawk"
# asdf ruby
INSTALL+=" autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev"
# asdf python
INSTALL+=" make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev"
# asdf direnv
INSTALL+=" direnv"

# install exa if available
if [ $(apt-cache search --names-only ^exa$ | wc -c) -ne 0 ]; then
    INSTALL+=" exa"
fi

sudo apt install -y $INSTALL

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

cargo install bat git-delta
#rm -rf ~/.cargo/registry


# Set default shell
if grep -sq 'docker\|lxc' /proc/1/cgroup; then
    echo "Set default shell manually, we are running inside a container.";
elif [ "$DEBIAN_FRONTEND" == "noninteractive" ]; then
    echo "Set default shell manually, we are running in an noninteractive environment.";
elif [[ "$SHELL" == *"zsh"* ]] ; then
    echo "Skipping to set shell, zsh already is your default shell."
else
    echo "Please provide your password in order to change your default shell to zsh."
    sudo chsh -s $(which zsh) $USER
fi
