HELPTEXT_HEADING := Bootstrapping Targets:

.PHONY: install
pipenv_command = python -m pipenv
install: git-hooks ## Install dependencies.
	command -v brew > /dev/null || { /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
	command -v pyenv > /dev/null || { brew install pyenv; }
	pyenv install "$$(cat .python-version)" --skip-existing
	pip install --upgrade --user pipenv
	$(pipenv_command) sync --dev
	$(pipenv_command) run ansible-galaxy install \
		--role-file requirements.yml \
		--force

$(vault_password_file):
	@echo 'Generating random vault password ...'
	@LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 32 > $@

$(become_password_file): $(vault_password_file)
	@read -sp 'Enter your admin password (so Ansible can execute sudo commands): ' admin_password; \
		echo "ansible_sudo_pass: $$admin_password" \
		| $(pipenv_command) run ansible-vault encrypt --vault-password-file $(vault_password_file) --output $@
