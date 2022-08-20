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
    
    In order to use `encfs` install [osxFUSE](https://osxfuse.github.io) fist.

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

[Meslo LG S](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo/S/Regular/complete)

## Dracula Color Theme

- [iTerm2](https://draculatheme.com/iterm)

- [Mate Terminal](https://github.com/pygaurav/mate-terminal-dracula-custom-theme)

- [Blink Shell](https://github.com/blinksh/themes/blob/master/themes/Dracula.js)

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
