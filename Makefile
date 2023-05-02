# Remove default suffixes as we don't use them.
.SUFFIXES:

# Set the Shell to Bash always to avoid surprises.
SHELL := /bin/bash

.PHONY: all
all: help ## Default target: Run help.

# Auto-generate help texts from end-of-line comments.
# See https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
USAGE_TEXT := Usage: make [make-options] <target> [options]
HELPTEXT_HEADING := Common Targets:
help: ## Show this help info.
	@printf "$(USAGE_TEXT)\n"
	@for makefile in $(MAKEFILE_LIST); do \
		echo; \
		grep '^HELPTEXT_HEADING := ' "$$makefile" | sed -E 's#.* := (.*)#\1#'; \
		grep -E '^[a-zA-Z_\.-]+:.*?## .*$$' "$$makefile" | sort | \
			awk 'BEGIN {FS = ":.*?## "}; {printf "  %-27s %s\n", $$1, $$2}'; \
	done

vault_password_file := vault-password.txt
become_password_file := become-password.secret

.PHONY: test

.PHONY: clean
clean: clean.git-hooks ## Remove artifacts.
	rm $(vault_password_file) $(become_password_file) || true

# Split out Make modules into `helpers/`.
-include helpers/*.mk helpers/**/*.mk
