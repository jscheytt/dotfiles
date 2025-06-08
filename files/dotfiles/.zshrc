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
plugins=(
  common-aliases
  evalcache
  git
  gitignore
  macos
)

source $ZSH/oh-my-zsh.sh

# User configuration
source "${HOME}/.secrets.sh"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Configure Homebrew.
_evalcache /opt/homebrew/bin/brew shellenv
# eval "$(/opt/homebrew/bin/brew shellenv)"

# Go
export GOPATH="$HOME"/go
# Add Go binaries to path.
export PATH="/usr/local/sbin:$GOPATH/bin:$PATH"

# Java: sdkman
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# Make v4
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Kubeswitch
source <(switcher init zsh)

# Python conf
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
_evalcache pyenv init --path
# eval "$(pyenv init -)"
# pipx
export PATH="$PATH:/Users/josiascheytt/.local/bin"

# Rust
export PATH="$PATH:/opt/homebrew/opt/rustup/bin:$HOME/.cargo/bin"

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

# fnm for Node.js versions
_evalcache fnm env --use-on-cd
# eval "$(fnm env --use-on-cd)"

# Testcontainers
# See https://java.testcontainers.org/supported_docker_environment/#colima
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# Set starting directory of new terminals (not new tabs)
export START=~/Documents
if [[ $PWD == $HOME ]]; then
  cd $START
fi

# Fix errors with colima
# See https://github.com/wagoodman/dive/issues/397#issuecomment-1231063268
export DOCKER_HOST=unix://$HOME/.colima/docker.sock
