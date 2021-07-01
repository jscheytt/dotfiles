#!/bin/sh
set -euo pipefail
set -x

which brew || {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
which pyenv || {
  brew install pyenv
}
which pipenv || {
  brew install pipenv
}
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook setup.yml -K

# RECOMMENDED: Install color schemes https://github.com/mbadolato/iTerm2-Color-Schemes
# RECOMMENDED: Copy settings from ./iterm2 to a location of your choice and use it as a starting point for your iTerm2 configuration
