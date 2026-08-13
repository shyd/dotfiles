# Dotfiles and OS setup

## Intro

Shell, editor, tmux, and OS setup for macOS and Debian/Ubuntu.

## Requirements

- `curl`
- Git
- On macOS, [Homebrew](https://brew.sh/)

<details>
  <summary>macOS</summary>

  Install Homebrew if it is not already available:

  ```bash
  bash <(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
  ```

  To use `encfs`, install [macFUSE](https://osxfuse.github.io/) first.
</details>

## Install

Run the bootstrap script:

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

For device-specific shell configuration, create `~/.zshrc.local`.

## Starship prompt

Starship is the sole prompt. Restart the shell after changing its configuration:

```bash
exec zsh
```

The Starship configuration uses standard ANSI colors, so its appearance follows
the active iTerm2 or VS Code terminal theme. It includes Nerd Font symbols.

## Serial sessions

`tio` is installed by the macOS and Debian/Ubuntu setup scripts. It passes
serial ANSI colors through to the terminal without imposing its own background:

```bash
tio -b 115200 /dev/tty.usbserial-DEVICE
```

For Ubuntu 22.04, enable the `universe` repository if `apt` cannot find `tio`.

## VS Code remote launch

When deploying the dotfiles on a remote machine, link the helper to launch new
VS Code windows from an existing remote connection.

```bash
mkdir -p ~/.local/bin
ln -s ~/.dotfiles/.local/bin/code ~/.local/bin/code
```

### Usage

1. Connect to the host with VS Code Remote.

2. In an SSH session, run `code <dir>` to open it in that remote session.

## Nerd Font

Use a current monospaced [Nerd Font](https://www.nerdfonts.com/font-downloads)
in the terminal and VS Code. The configuration is tested with Meslo LG and Hack;
the current Nerd Fonts download page is preferred over the retired direct-font
URLs previously listed here.

## Theme behavior

The shell tools and tmux use terminal ANSI colors, so they follow the active
terminal theme. Neovim selects Catppuccin Mocha for dark terminals and Latte
for light terminals when `COLORFGBG` is available.

## Install a newer version of `eza`

As exa is not maintained anymore I switched to the fork eza.

See here [eza-community/eza](https://github.com/eza-community/eza)

Or install it with cargo.

To uninstall manually installed eza run `sudo rm -rf /usr/local/bin/eza`.

## Install `duf` if you wish

Since [duf](https://github.com/muesli/duf) is not available for all distros I use, just try the package manager if it's available.

## Pretty `git show` with git-delta

This only works if [git-delta](https://github.com/dandavison/delta) is installed. You can use cargo to do so.

## Updating dotfiles and tools

Simply run

```
dotfiles-update
```

`dotfiles-update` fast-forwards the repository and reapplies local links and
configuration. It does not install packages or update external tools. Use
`dotfiles-bootstrap` for first-machine setup and `dotfiles-upgrade-tools` to
explicitly update shell, editor, fzf, and tmux plugins.

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
