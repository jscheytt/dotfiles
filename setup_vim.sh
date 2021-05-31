#!/bin/sh
set -euo pipefail
set -x

# Install amix' awesome vimrc
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install custom plugins
pathogen https://github.com/PProvost/vim-ps1.git
pathogen https://github.com/bryanmylee/vim-colorscheme-icons.git
pathogen https://github.com/chr4/nginx.vim
pathogen https://github.com/editorconfig/editorconfig-vim.git
pathogen https://github.com/fatih/vim-go
pathogen https://github.com/hashivim/vim-terraform.git
pathogen https://github.com/mechatroner/rainbow_csv.git
pathogen https://github.com/mustache/vim-mustache-handlebars.git
pathogen https://github.com/ryanoasis/vim-devicons.git
pathogen https://github.com/slim-template/vim-slim.git
pathogen https://github.com/thoughtbot/vim-rspec.git
pathogen https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git
pathogen https://github.com/tpope/vim-rails.git
