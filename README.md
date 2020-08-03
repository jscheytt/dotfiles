# My [Dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)

## Dependencies

I use the following tools and you might need them to get this dotfiles repo to work:

* [iTerm2](https://www.iterm2.com/)
* [iTerm2 Color Schemes](https://iterm2colorschemes.com/)
* [oh-my-zsh](https://ohmyz.sh/)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

### If you happen to use vim ...

* [vimrc](https://github.com/amix/vimrc) repo from amix comes first ...
* ... then the following vim plugins (installed with Pathogen):
    * editorconfig-vim
    * nginx.vim
    * rainbow_csv
    * vim-devicons
    * vim-go
    * vim-instant-markdown
    * vim-mustache-handlebars
    * vim-nerdtree-syntax-highlight
    * vim-pandoc
    * vim-ps1
    * vim-rails
    * vim-rspec
    * vim-slim
    * vim-terraform

## Usage

1. Install dependencies
1. Clone repo to a path of your choice
1. Create symlinks to all relevant files by executing the script (replace `PATH` with the filepath to the cloned repo):  
`./create_symlinks.sh PATH`
1. Point iTerm2 to the configuration in this repository: https://apple.stackexchange.com/a/140624
1. Update whenever you like by `git pull`
1. Enjoy 🙂
