#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# set -x # DEBUG

### This is the installation script for Gitpod

# brew and pipenv are assumed
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook gitpod.yml \
  --inventory inventory \
  -vv
