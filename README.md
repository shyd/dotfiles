# My dotfiles and OS setup

## Intro

My repo to setup OS and dotfiles on Linux and MacOS

## Requirements

- curl

## Install

1. On MacOS make sure brew is installed

    ```bash
    bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
    ```
    
    In order to use `encfs` install [osxFUSE](https://osxfuse.github.io) first.

2. Make sure curl is installed

    1. On Debian etc

        ```bash
        sudo apt update -y && sudo apt install curl -y
        ```

    2. On MacOS

        ```bash
        brew install curl
        ```

3. Run initiation script

    ```bash
    bash <(curl -fsSL https://raw.githubusercontent.com/shyd/dotfiles/main/run-once.sh)
    ```

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

Add the following to your `.gitconfig`:

```
[user]
	name = Me
	email = me@me.me
[init]
	defaultBranch = main

[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only
[add.interactive]
    useBuiltin = false # required for git 2.37.0

[delta]
    navigate = true    # use n and N to move between diff sections
    light = false      # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
    side-by-side = false

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

This only works if [git-delta](https://github.com/dandavison/delta) is installed. You can use cargo to do so.

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
