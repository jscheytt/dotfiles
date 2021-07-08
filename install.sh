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
pyenv install $(cat .python-version) --skip-existing
pipenv sync
