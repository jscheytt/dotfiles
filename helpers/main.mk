HELPTEXT_HEADING := Main Targets:

.PHONY: build
playbook = main.yaml
build: install $(vault_password_file) $(become_password_file) ## Run Ansible playbook. Accepted parameters: playbook
	pipenv run ansible-playbook $(playbook) \
		--extra-vars="ansible_python_interpreter=$$(which python)" \
		--inventory inventory \
		--vault-password-file $(vault_password_file) \
		-vv
