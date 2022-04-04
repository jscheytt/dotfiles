### Taken and adapted from https://github.com/upbound/build/blob/master/makelib/common.mk

# Remove default suffixes as we don't use them
.SUFFIXES:

# Set the shell to bash always
SHELL := /bin/bash

SELF_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

vault_password_file := vault-password.txt
become_password_file := become-password.secret

.PHONY: help
USAGE_TEXT := Usage: make [make-options] <target> [options]
HELPTEXT_HEADING := Common Targets:
# See https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help info.
	@printf "$(USAGE_TEXT)\n"
	@for makefile in $(MAKEFILE_LIST); do \
		echo; \
		grep '^HELPTEXT_HEADING := ' "$$makefile" | sed -E 's#.* := (.*)#\1#'; \
		grep -E '^[a-zA-Z_\.-]+:.*?## .*$$' "$$makefile" | sort | \
			awk 'BEGIN {FS = ":.*?## "}; {printf "  %-27s %s\n", $$1, $$2}'; \
	done

.PHONY: all
all: update install build

.PHONY: update
update: ## Run a git pull.
	@git pull

.PHONY: install
install: ## Install dependencies.
	./install.sh

$(vault_password_file):
	@echo 'Generating random vault password ...'
	@LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 32 > $@

$(become_password_file): $(vault_password_file)
	@read -sp 'Enter your admin password (so Ansible can execute sudo commands): ' admin_password; \
		echo "ansible_sudo_pass: $$admin_password" \
		| pipenv run ansible-vault encrypt --vault-password-file $(vault_password_file) --output $@

.PHONY: build
build: $(vault_password_file) $(become_password_file) ## Run Ansible playbook.
	pipenv run ansible-playbook main.yml \
		--vault-password-file $(vault_password_file) \
		--inventory inventory \
		-vv

.PHONY: lint
lint: ## Run linters.
	pipenv run yamllint -c files/dotfiles/.config/yamllint/config .
	pipenv run ansible-lint .

.PHONY: clean
clean: ## Clean up artifacts.
	rm $(vault_password_file) $(become_password_file) || true
