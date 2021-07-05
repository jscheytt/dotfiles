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
pyenv install $(cat .python-version)
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook setup.yml -vv -K
