HELPTEXT_HEADING := Bootstrapping Targets:

.PHONY: install
install: git-hooks ## Install dependencies.
	command -v brew > /dev/null || { /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
	command -v pyenv > /dev/null || { brew install pyenv; }
	command -v pipenv > /dev/null || { brew install pipenv; }
	pyenv install "$$(cat .python-version)" --skip-existing
	pip install --user pipenv
	pipenv sync --dev
	pipenv run ansible-galaxy install -r requirements.yml

$(vault_password_file):
	@echo 'Generating random vault password ...'
	@LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 32 > $@

$(become_password_file): $(vault_password_file)
	@read -sp 'Enter your admin password (so Ansible can execute sudo commands): ' admin_password; \
		echo "ansible_sudo_pass: $$admin_password" \
		| pipenv run ansible-vault encrypt --vault-password-file $(vault_password_file) --output $@
