define GIT_HELPTEXT

Git Targets:
	branches.prune.all

endef
LOCAL_HELPTEXT += $(GIT_HELPTEXT)

.PHONY: branches.prune.all
branches.prune.all:
	@source $(SELF_DIR)roles/js_mac/files/dotfiles/.oh-my-zsh/custom/functions.sh ;\
	find "$$HOME"/Documents -path "*/.git" -not -path "*build*" -not -path "*.diff-kustomize*" -exec dirname {} \; \
		| xargs -I {} bash -c 'git-prune-local-branches "$$@"' _ {}
