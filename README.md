# My [Dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)

## What is this repo for?

I strive for reproducibility a lot, so I also want the process of setting up a new machine be as automatic and idempotent as possible.

This repo can do the following for me (and also for you 😊):

* Install all dependencies mentioned in `Brewfile` (Homebrew), and `Pipfile` (Python)
* Set up iTerm2 as terminal with (ohmy)zsh, p10k, itermocil
* Set some sane global git configuration
* Set up vim with some plugins

## Recommended Usage

1. Clone repo to a path of your choice  
`git clone git@github.com:jscheytt/dotfiles.git`
1. Run `./install.sh`
1. Encrypt your local admin password:
    1. Generate a secure password e.g. with LastPass
    1. Save it into `./vault-password.txt`
    1. Create a secret:  
    `pipenv run ansible-vault create --vault-password-file vault-password.txt become-password.secret`
    1. Put your admin password into this file with this yaml key:  
    `ansible_sudo_pass: YOUR_ADMIN_PASSWORD`
1. Run `./setup.sh`
1. Enjoy 🙂

## Updating

Just do

```sh
git pull
./install.sh
./setup.sh
```
