HELPTEXT_HEADING := Linting Targets:

.PHONY: lint
lint: lint.yaml lint.ansible ## Run linters.

.PHONY: lint.yaml
lint.yaml: ## Lint yaml files.
	yamllint -c files/dotfiles/.config/yamllint/config .

.PHONY: lint.ansible
lint.ansible: ## Lint ansible files.
	ANSIBLE_VAULT_PASSWORD_FILE=$(vault_password_file) \
		pipenv run ansible-lint \
		--show-relpath
