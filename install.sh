#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
# set -x # DEBUG

### This is the installation script for Gitpod
### It has a hard timeout of 2mins, so it's a very stripped down version of the
# normal installation.

# Enter and leave this script's directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Make sure to go back to previous directory
trap popd EXIT
pushd "$SCRIPT_DIR"

# Install Ansible & Requirements
python3 -m pip install --user ansible
ansible-galaxy install -r requirements-gitpod.yml

# Ignore desired Python version
rm -f .python-version
# Install everything via Ansible
ansible-playbook gitpod.yml \
  --inventory inventory \
  -vv
