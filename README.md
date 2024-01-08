# My dotfiles and OS setup

## Intro

My repo to setup OS and dotfiles on Linux and MacOS

## Requirements

- curl

<details>
  <summary>MacOS</summary>

  On MacOS make sure brew is installed

  ```bash
  bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
  ```

  In order to use `encfs` install [osxFUSE](https://osxfuse.github.io) first.
</details>

## Install

Run initiation script

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/shyd/dotfiles/main/run-once.sh)
```

## Customizing

Save env vars, etc in a `.extra` file, that looks something like this:

```
###
### Git credentials
###

GH_USER="nickname"
GIT_AUTHOR_NAME="Your Name"
GIT_AUTHOR_EMAIL="email@you.com"

GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global github.user "$GH_USER"
```

## Local configuration

To have an individual config for each device, create a `.zshrc.local`in your home.

## VS Code remote launch

When deploying the dotfiles on a remote machine, you can link a script to launch new code windows if already connected.

```bash
ln -s ~/.dotfiles/.local/bin/code ~/.local/bin/code
```

### Usage

 1. remote connect VS Code

 2. in a ssh session type `code <dir>` to launch it in the existing remote session

## Nerd Font

### [Meslo LG S](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo/S/Regular/complete)

```bash
curl --create-dirs -fLo ~/.local/share/fonts/"Meslo LG S Regular Nerd Font Complete Mono.ttf" \
https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/complete/Meslo%20LG%20S%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

curl --create-dirs -fLo ~/.local/share/fonts/"Meslo LG S Regular Nerd Font Complete.ttf" \
https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/complete/Meslo%20LG%20S%20Regular%20Nerd%20Font%20Complete.ttf
```

### [Hack](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack/Regular/complete)

```bash
curl --create-dirs -fLo ~/.local/share/fonts/"Hack Regular Nerd Font Complete Mono.ttf" \
https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

curl --create-dirs -fLo ~/.local/share/fonts/"Hack Regular Nerd Font Complete.ttf" \
https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
```

## Dracula Color Theme

- [iTerm2](https://draculatheme.com/iterm)

- [Mate Terminal](https://github.com/pygaurav/mate-terminal-dracula-custom-theme)

- [Blink Shell](https://github.com/blinksh/themes/blob/master/themes/Dracula.js)

## Install a newer version of `exa`

First uninstall exa. Then

```
EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
sudo unzip -q exa.zip bin/exa -d /usr/local
rm exa.zip
```

Or install it with cargo.

To uninstall manually installed exa run `sudo rm -rf /usr/local/bin/exa`.

## Install `duf` if you wish

Since [duf](https://github.com/muesli/duf) is not available for all distros I use, just try the package manager if it's available.

## Pretty `git show` with git-delta

This only works if [git-delta](https://github.com/dandavison/delta) is installed. You can use cargo to do so.

## How to update the dotfiles and install new packages

Simply run

```
dotfiles-update
```

## Raspberry Pi related setup

### same groups as user <pi>

List pi's groups
```bash
# groups pi
pi : pi adm dialout cdrom sudo audio video plugdev games users input netdev spi i2c gpio
```

add them to other users with 
```bash
usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio dennis
```

## Encoding in Powershell

If there are encoding errors in Powershell when operating e.g. docker containers, install and use a [Nerdfont](https://www.nerdfonts.com/font-downloads)
like [Hack Regular Nerd Font Complete Mono Windows Compatible](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack).
