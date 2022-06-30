#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# set -x # DEBUG

### This is the installation script for Gitpod.
### It has a hard timeout of 2mins, so it's a very stripped down version of the
### normal installation.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Ignore desired Python version
rm -f "${SCRIPT_DIR}"/.python-version

# Install Ansible
python3 -m pip install --user ansible

# Install only dotfiles via Ansible
ansible-playbook "${SCRIPT_DIR}"/gitpod.yml \
  --inventory "${SCRIPT_DIR}"/inventory \
  -vv

# Install Homebrew packages
brew install neovim
