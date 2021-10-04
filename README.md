# My [Dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)

![lint](https://github.com/jscheytt/dotfiles/actions/workflows/lint.yml/badge.svg)

## What is this repo for?

I strive for reproducibility a lot, so I also want the process of setting up a new machine be as automatic and idempotent as possible.

This repo can do the following for me (and also for you 😊):

* Install all dependencies mentioned in `Brewfile` (Homebrew), and `Pipfile` (Python)
* Set up iTerm2 as terminal with (ohmy)zsh, p10k, itermocil
* Set some sane global git configuration
* Set up vim with some plugins

## Recommended Usage

* You can always run `make` to see all available commands.
* Initial usage: `make install build`
* Updating: `make update`
* Running only the installation: `make install`
* Running the setup playbook: `make build`
* Starting from a clean slate: `make clean`

## References and Kudos

* Thanks to Adam Johnson for his [mac-ansible role](https://github.com/adamchainz/mac-ansible).
