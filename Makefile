# Remove default suffixes as we don't use them
.SUFFIXES:

# Set the Shell to Bash always
SHELL := /bin/bash

vault_password_file := vault-password.txt
become_password_file := become-password.secret

define HELPTEXT
Usage: make [make-options] <target> [options]

Common Targets:
    build        Run Ansible playbook.
    clean        Clean up artifacts.
    help         Show this help info.
    install      Install dependencies.
    lint         Run linters.
    update       Run a git pull.
endef
export HELPTEXT

.PHONY: help
help:
	@echo "$$HELPTEXT"

.PHONY: all
all: update install build

.PHONY: update
update:
	@git pull

.PHONY: install
install:
	./install.sh

$(vault_password_file):
	@echo 'Generating random vault password ...'
	@LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 32 > $@

$(become_password_file): $(vault_password_file)
	@read -sp 'Enter your admin password (so Ansible can execute sudo commands): ' admin_password; \
		echo "ansible_sudo_pass: $$admin_password" \
		| pipenv run ansible-vault encrypt --vault-password-file $(vault_password_file) --output $@

.PHONY: build
build: $(vault_password_file) $(become_password_file)
	pipenv run ansible-playbook setup.yml --vault-password-file $(vault_password_file) -vv

.PHONY: lint
lint:
	pipenv run ansible-lint

.PHONY: clean
clean:
	rm $(vault_password_file) $(become_password_file) || true
