# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## Overview

This is a personal macOS dotfiles repository.
It uses **Ansible** to idempotently provision a machine:
Install Homebrew/Python dependencies, set up (oh-my-)zsh, symlink dotfiles into `$HOME`, and configure NeoVim.
All orchestration is exposed through **go-task** (`Taskfile.yml`) and Python tooling is managed by **uv**.

## Common Commands

Tasks are the primary entry point. Run `task` (or `task help`) to list everything.

- `task install` — install Homebrew, uv, the target Python, Python deps, and Ansible collections/roles. Also installs git hooks.
- `task run` — run the main Ansible playbook (`main.yml`). Depends on `install` plus become/vault password setup. Extra Ansible args pass through via `CLI_ARGS`, e.g. `task run -- --tags dotfiles`.
- `task clean` — remove the generated vault/become password files and reset the Python environment.
- `task clean run` — provision from a clean slate.

Linting (also run by CI via MegaLinter and by the pre-commit hook on staged YAML):

- `task lint:all` — run all linters.
- `task lint:ansible` — `ansible-lint` only.
- `task lint:yaml` — `yamllint` using `files/dotfiles/.config/yamllint/config`.

Running Ansible directly (task `run` wraps this):
The playbook is invoked with `uv run ansible-playbook`, so always prefix Ansible commands with `uv run`.
Target a single concern with `--tags` (available tags: `homebrew`, `oh-my-zsh`, `dotfiles`, `neovim`), e.g. `task run -- --tags neovim`.

## Architecture

- `main.yml` is the single playbook targeting `localhost` (see `inventory`, which uses `ansible_connection=local`). It applies the `geerlingguy.mac.homebrew` role, then imports task files from `tasks/` — each gated behind a tag.
- `tasks/` holds the imported task files: `oh-my-zsh.yml`, `dotfiles.yml`, `neovim.yml`.
- `tasks/dotfiles.yml` is the core mechanism: it recursively finds every file under `files/dotfiles/`, recreates the directory tree under `$HOME`, and **symlinks** each file into place. So editing a dotfile means editing the tracked file in `files/dotfiles/` (the `$HOME` copy is just a symlink back into this repo).
- `files/dotfiles/` mirrors the layout of `$HOME` (e.g. `.zshrc`, `.gitconfig`, `.config/nvim/`, `.ssh/`). Add a new dotfile by placing it here at its `$HOME`-relative path.
- Dependency sources: `Brewfile` (Homebrew, consumed by the homebrew role via `homebrew_brewfile_dir`), `pyproject.toml` + `uv.lock` (Python, via uv), and `requirements.yml` (Ansible collections and roles installed into `.ansible/`).
- `scripts/*.taskfile.yml` are Taskfile includes (`git-hooks`, `lint`, `setup`) merged into the root `Taskfile.yml`.

## Secrets

Provisioning requires two generated, git-ignored files (created automatically by `task run` dependencies, or via `task setup:vault-password` / `task setup:become-password`):

- `vault-password.txt` — a random 32-char Ansible Vault password.
- `become-password.secret` — the sudo password, vault-encrypted and included as `vars_files` in `main.yml`. Creating it prompts interactively for the admin password.

`ansible-lint` needs the vault password available, so `task lint:ansible` sets `ANSIBLE_VAULT_PASSWORD_FILE` automatically.
Never commit these files or decrypted secret contents.

## Conventions

- YAML/shell indentation is 2 spaces (`.editorconfig`); files end with a newline (LF).
- `ansible-lint` is configured via `.ansible-lint` (the `git-latest` rule is skipped, so pinning git repos to `HEAD`/branches in tasks is allowed).
- Dependencies are pinned and kept current by Renovate (`renovate.json`); most non-feature commits are lock-file maintenance.
- CI runs MegaLinter (`.github/workflows/lint.yml`), configured by `.mega-linter.yml`. Lua linting uses `selene`/`luacheck` (`selene.toml`, `.luacheckrc`) for NeoVim config.
