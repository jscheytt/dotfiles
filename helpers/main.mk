HELPTEXT_HEADING := Main Targets:

.PHONY: build
playbook = main.yml
build: $(vault_password_file) $(become_password_file) ## Run Ansible playbook. Accepted parameters: playbook
	$(pipenv_command) run ansible-playbook $(playbook) \
		--extra-vars="ansible_python_interpreter=$$(which python)" \
		--inventory inventory \
		--vault-password-file $(vault_password_file) \
		-vv

$(vault_password_file):
	@echo 'Generating random vault password ...'
	@LC_ALL=C tr -dc A-Za-z0-9 < /dev/urandom | head -c 32 > $@

$(become_password_file): $(vault_password_file)
	@read -sp 'Enter your admin password (so Ansible can execute sudo commands): ' admin_password; \
		echo "ansible_sudo_pass: $$admin_password" \
		| $(pipenv_command) run ansible-vault encrypt --vault-password-file $(vault_password_file) --output $@

.PHONY: update
update: ## Update pipenv dependencies.
	$(pipenv_command) update --dev
