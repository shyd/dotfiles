# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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


# use gsed, coreutils instead of macos sed
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# use lesspipe.sh if installed https://github.com/wofr06/lesspipe
[[ ! -f /usr/local/bin/lesspipe.sh ]] || LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN

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
# Dacula theme for fzf
#export FZF_DEFAULT_OPTS=" --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --prompt='∼ ' --pointer='▶' --marker='✓'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --color=gutter:#44475a --prompt='∼ ' --pointer='▶' --marker='✓'"

# source cargo if not installed via package manager
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

export BAT_THEME="Dracula"

enable-fzf-tab

export LESSOPEN='|~/.dotfiles/.lessfilter %s'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
        fzf-preview 'echo ${(P)word}'


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ---------------------
# eza universal Dracula
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

	export PATH="$HOME/.cargo/bin:$PATH"

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
