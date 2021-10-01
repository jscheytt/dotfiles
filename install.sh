#!/bin/bash
set -euo pipefail
# set -x # DEBUG

command -v brew > /dev/null || { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
command -v pyenv > /dev/null|| { brew install pyenv; }
command -v pipenv > /dev/null|| { brew install pipenv; }
pyenv install "$(cat .python-version)" --skip-existing
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
