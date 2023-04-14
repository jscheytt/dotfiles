HELPTEXT_HEADING := Git Hooks Targets:

# Symlink git hooks
SELF_DIR := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
git_hooks_source_dir := $(SELF_DIR)/../.git-hooks
git_hooks_destination_dir := .git/hooks
git_hooks_sources := $(wildcard $(git_hooks_source_dir)/*)
git_hooks_destinations := $(patsubst $(git_hooks_source_dir)/%,$(git_hooks_destination_dir)/%,$(git_hooks_sources))
$(git_hooks_destination_dir)/%: $(git_hooks_source_dir)/%
	ln -fs ../../$< $@
.PHONY: git-hooks
git-hooks: $(git_hooks_destinations) ## Install Git hooks.

.PHONY: clean.git-hooks
clean.git-hooks: ## Remove Git hooks.
	rm -rf $(git_hooks_destinations) || true
