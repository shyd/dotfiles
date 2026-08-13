prepend_path_if_dir() {
  local dir="$1"

  [[ -d "$dir" ]] || return
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$dir:$PATH" ;;
  esac
}

prepend_path_if_dir "$HOME/.local/bin"

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Starship provides the prompt; Oh My Zsh does not load a separate theme.
ZSH_THEME=""

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  z
  zsh-syntax-highlighting
  zsh-completions
  k
  docker
  docker-compose
  fzf-tab
  fzf-zsh-plugin
  direnv
  virtualenv
)

source $ZSH/oh-my-zsh.sh

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# set locales
export LANGUAGE=en_US.UTF-8

export LANG="$LANGUAGE"
export LC_ALL="$LANGUAGE"
#export GDM_LANG="$LANGUAGE"

export EDITOR=vim
if command -v nvim 2>&1 >/dev/null; then
	export EDITOR=nvim
fi

# systemctl edit myservice to use vim instead of nano
export SYSTEMD_EDITOR="$EDITOR"


# Prefer GNU sed and coreutils when their Homebrew shims are installed.
prepend_path_if_dir "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
prepend_path_if_dir "/opt/homebrew/opt/coreutils/libexec/gnubin"


# Custom zsh stuff here
[[ ! -f ~/.zshrc.local.grml ]] || source ~/.zshrc.local.grml
# if present, load local stuff here
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

# gh copilot if installed
if command -v github-copilot-cli 2>&1 >/dev/null; then
    eval "$(github-copilot-cli alias -- "$0")"
fi

[[ ! -f ~/.aliases ]] || source ~/.aliases
[[ ! -f ~/.functions ]] || source ~/.functions
[[ ! -f ~/.extra ]] || source ~/.extra

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-git.sh ] && source ~/.fzf-git.sh
# ANSI colors let the active terminal theme control fzf's appearance.
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:-1,bg:-1,fg+:bright-white,bg+:-1,hl:magenta,hl+:magenta --color=info:yellow,prompt:green,pointer:cyan,marker:cyan,spinner:yellow,header:blue,gutter:-1 --prompt='∼ ' --pointer='▶' --marker='✓'"

# source cargo if not installed via package manager
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Use the terminal's ANSI palette so bat follows the active terminal theme.
export BAT_THEME="ansi"

enable-fzf-tab

export LESSOPEN='|~/.dotfiles/.lessfilter %s'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
        fzf-preview 'echo ${(P)word}'


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ---------------------
# eza colors
# ---------------------
export EZA_COLORS="\
uu=36:\
uR=31:\
un=35:\
gu=37:\
da=2;34:\
ur=34:\
uw=95:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:\
xx=95:"

# OS dependant configuration
if [[ -r /etc/debian_version ]] ; then

	# for user root
	if [[ $UID -eq 0 ]] ; then
		#a3# Execute \kbd{apt update && apt dist-upgrade}
		alias upgrade="apt update && apt dist-upgrade"
		alias scaja='sudo caja'
		alias debian-chroot='chroot /opt/debian-chroot /bin/bash'
		alias rsync-backup='rsync -avP --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/*/.gvfs} --delete'

		### variables
		export RSYNCEXLUDE='{/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/home/*/.gvfs}'

	# for users other than root
	else
		#a3# Execute \kbd{apt update && apt dist-upgrade}
		alias upgrade="sudo apt update && sudo apt dist-upgrade"
	fi

	#a3# Execute \kbd{apt-cache search}
    alias acs='apt-cache search'
    #a3# Execute \kbd{apt-cache show}
    alias acsh='apt-cache show'
    #a3# Execute \kbd{apt-cache policy}
    alias acp='apt-cache policy'
    #a3# Execute \kbd{apt dist-upgrade}
    salias adg="apt dist-upgrade"
    #a3# Execute \kbd{apt install}
    salias agi="apt install"
    #a3# Execute \kbd{aptitude install}
    salias ati="aptitude install"
    #a3# Execute \kbd{apt upgrade}
    salias ag="apt upgrade"
    #a3# Execute \kbd{apt update}
    salias au="apt update"
    #a3# Execute \kbd{aptitude update ; aptitude safe-upgrade}
    salias -a up="aptitude update ; aptitude safe-upgrade"
    #a3# Execute \kbd{dpkg-buildpackage}
    alias dbp='dpkg-buildpackage'
    #a3# Execute \kbd{grep-excuses}
    alias ge='grep-excuses'

	### commands
	#alias rsync-copy='rsync -avP'
	alias mount-safe-encfs='encfs --extpass="cat .keyfile" ~/ownCloud/Safe/ ~/Safe/'
	alias umount-safe-encfs='fusermount -u ~/Safe'


	# bash function to decompress archives - http://www.shell-fu.org/lister.php?id=375
	extract() {
		if [ -f $1 ] ; then
			case $1 in
				*.tar.bz2)   tar xvjf $1        ;;
				*.tar.gz)    tar xvzf $1     ;;
				*.tar.xz)    tar xvJf $1     ;;
				*.bz2)       bunzip2 $1       ;;
				*.rar)       unrar x $1     ;;
				*.gz)        gunzip $1     ;;
				*.tar)       tar xvf $1        ;;
				*.tbz2)      tar xvjf $1      ;;
				*.tgz)       tar xvzf $1       ;;
				*.zip)       unzip $1     ;;
				*.Z)         uncompress $1  ;;
				*.7z)        7z x $1    ;;
				*)           echo "'$1' cannot be extracted via >extract<" ;;
			esac
		else
			echo "'$1' is not a valid file"
		fi
	}

	prepend_path_if_dir "$HOME/.cargo/bin"

elif [[ "$OSTYPE" == "darwin"* ]]; then
	function hideAllFiles() {
		defaults write com.apple.finder AppleShowAllFiles -bool NO
		killall Finder
	}

	function showAllFiles() {
		defaults write com.apple.finder AppleShowAllFiles -bool YES
		killall Finder
	}
fi

if [[ -d "$HOME/.nvm" ]]; then
	export NVM_DIR="$HOME/.nvm"
	[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
	[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
fi

stm32cubemx_path=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
stm32_prg_path=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin
if [[ -d "$stm32cubemx_path" ]]; then
	export STM32CubeMX_PATH="$stm32cubemx_path"
fi
if [[ -d "$stm32_prg_path" ]]; then
	export STM32_PRG_PATH="$stm32_prg_path"
fi
unset stm32cubemx_path stm32_prg_path

unfunction prepend_path_if_dir
