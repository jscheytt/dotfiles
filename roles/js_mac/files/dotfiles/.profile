# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile and ~/.zprofile:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# NVM path management from ansible BEGIN
. ~/.nvm/nvm.sh
# NVM path management from ansible END
. "$HOME/.cargo/env"
