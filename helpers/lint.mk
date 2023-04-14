HELPTEXT_HEADING := Linting Targets:

.PHONY: lint
lint: install ## Run linters.
	pipenv run yamllint -c files/dotfiles/.config/yamllint/config .
	pipenv run ansible-lint .
