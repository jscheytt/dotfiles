#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# set -x # DEBUG

### This is the installation script for Gitpod

command -v brew > /dev/null || { /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
command -v pipenv > /dev/null || { brew install pipenv; }
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook gitpod.yml \
  --inventory inventory \
  -vv
