#!/bin/sh
set -euo pipefail
set -x

# Tell me where you cloned this repo to (relative to ~)
install_path="${1:-Documents/ecosystem/dotfiles}"

cd ~
ln -s $install_path/zsh/zshrc.txt .zshrc
ln -s $install_path/zsh/p10k.zsh .p10k.zsh

git config --global core.attributesfile $install_path/.gitattributes

cd ~/.oh-my-zsh/custom
ln -s ../../$install_path/zsh/aliases.zsh aliases.zsh

cd ~/.vim_runtime
ln -s ../$install_path/vim/my_configs.vim my_configs.vim

cd ~/.config/joplin
ln -s ../../$install_path/joplin_keymap.json keymap.json

mkdir -p ~/.teamocil
cd ~/.teamocil
ln -s ../$install_path/teamocil/upgrade.yml upgrade.yml

mkdir -p ~/.vim/after/ftplugin
cd ~/.vim/after/ftplugin
ln -s ../../../$install_path/vim/conventional-commits.vim gitcommit.vim
