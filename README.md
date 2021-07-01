# My [Dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)

## What is this repo for?

I strive for reproducibility a lot, so I also want the process of setting up a new machine be as automatic and idempotent as possible.

This repo can do the following for me (and also for you 😊):

* Install all dependencies mentioned in `Brewfile` (Homebrew), and `Pipfile` (Python)
* Set up iTerm2 as terminal with (ohmy)zsh, p10k, itermocil
* Set some sane global git configuration
* Set up vim with some plugins

## Recommended Usage

1. Install dependencies
1. Clone repo to a path of your choice  
`git clone git@github.com:jscheytt/dotfiles.git`
1. Enter repo directory and run setup:  
`./setup.sh`
1. Point iTerm2 to the configuration file `iterm2/com.googlecode.iterm2.plist`. See https://apple.stackexchange.com/a/140624
1. Update whenever you like by `git pull`
1. Enjoy 🙂
