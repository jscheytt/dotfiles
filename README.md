# My [Dotfiles](https://wiki.archlinux.org/title/Dotfiles)

[![lint](https://github.com/jscheytt/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/jscheytt/dotfiles/actions/workflows/lint.yml)

## What is this repo for?

I strive for reproducibility a lot, so I also want the process of setting up a new machine be as automatic and idempotent as possible.

This repo can do the following for me (and also for you 😊):

* Install all dependencies mentioned in `Brewfile` (Homebrew), and `Pipfile` (Python).
* Set up (ohmy)zsh and dotfiles.
* Set some sane global git configuration.
* Set up NeoVim with some plugins.

## Recommended Usage

**To run the tasks, install [go-task](https://taskfile.dev/installation/).**

You can always run `task` to see all available commands.

Examples:
* Run only the installation of dependencies: `task install`
* Run the main playbook: `task run`
* Update pipenv dependencies: `task update`
* Start from a clean slate: `task clean run`

## Full initial setup

See [Initial Setup](docs/init.md)

## References and Kudos

* Thanks to Adam Johnson for his [mac-ansible role](https://github.com/adamchainz/mac-ansible).
