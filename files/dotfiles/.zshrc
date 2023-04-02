# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export NVM_AUTO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
plugins=(
  common-aliases
  evalcache
  git
  forgit
  macos
  zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Load Zsh tools for syntax highlighting and autosuggestions
HOMEBREW_FOLDER="/usr/local/share"
source "$HOMEBREW_FOLDER/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_FOLDER/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Go
export GOPATH="$HOME"/go

# Add to path:
# * Homebrew binaries
# * Go binaries
export PATH="/usr/local/sbin:$GOPATH/bin:$PATH"

# Python conf
_evalcache pyenv init -
# eval "$(pyenv init -)"

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export VISUAL='nvim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Kubernetes configuration
# KUBECONFIG_PATH=~/.kube
# kubeconfig_sub_path=${KUBECONFIG_PATH}/configs
# export KUBECONFIG=${KUBECONFIG_PATH}/config:$(echo ${kubeconfig_sub_path}/* | tr ' ' ':')

# Bat configuration
export BAT_THEME="OneHalfLight"

# zoxide
_evalcache zoxide init zsh
# eval "$(zoxide init zsh)"

# Customer specific includes
source ~/Documents/.customer-specifics.sh || true

# Set starting directory of new terminals (not new tabs)
export START=~/Documents
if [[ $PWD == $HOME ]]; then
  cd $START
fi
