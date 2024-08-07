HELPTEXT_HEADING := Install Targets:

.PHONY: install
pipenv_command = python3 -m pipenv
install: git-hooks ## Install dependencies.
	@# Install Xcode for Homebrew.
	xcode-select --install
	@# Install Homebrew.
	command -v brew > /dev/null || { /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
	@# Install pyenv.
	command -v pyenv > /dev/null || { brew install pyenv; }
	@# Install target Python version.
	pyenv install "$$(cat .python-version)" --skip-existing
	@# Install pipenv.
	pip3 install --break-system-packages --upgrade --user pipenv
	@# Install Python dependencies from Pipfile.
	$(pipenv_command) sync --dev
	@# Install Ansible collections and modules.
	$(pipenv_command) run ansible-galaxy install \
		--role-file requirements.yml \
		--force
