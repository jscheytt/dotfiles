#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# set -x # DEBUG

### This is the installation script for Gitpod


# brew is assumed
command -v pipenv > /dev/null || { brew install pipenv; }

# Enter and leave this directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Make sure to go back to previous directory
trap popd EXIT
pushd "$SCRIPT_DIR"
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook gitpod.yml \
  --inventory inventory \
  -vv
