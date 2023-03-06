# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
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
  asdf
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# use lesspipe.sh if installed https://github.com/wofr06/lesspipe
[[ ! -f /usr/local/bin/lesspipe.sh ]] || LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; export LESSOPEN

# Custom zsh stuff here
[[ ! -f ~/.zshrc.local.grml ]] || source ~/.zshrc.local.grml
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
[[ ! -f ~/.aliases ]] || source ~/.aliases
[[ ! -f ~/.functions ]] || source ~/.functions
[[ ! -f ~/.extra ]] || source ~/.extra

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf-git.sh ] && source ~/.fzf-git.sh
# Dacula theme for fzf
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --color=gutter:#44475a --prompt='∼ ' --pointer='▶' --marker='✓'"

export PATH="$HOME/.local/bin:$PATH"

# use gsed instead of macos sed
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# source cargo if not installed via package manager
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

enable-fzf-tab
