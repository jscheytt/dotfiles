#!/bin/sh
set -euo pipefail
set -x

pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook setup.yml --vault-password-file vault-password.txt -vv
