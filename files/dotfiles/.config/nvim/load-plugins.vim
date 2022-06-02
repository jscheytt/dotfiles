" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

""" Basics & UI

" Solarized Theme
Plug 'altercation/vim-colors-solarized'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File Tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Buffer Management (leader+o)
Plug 'vim-scripts/bufexplorer.zip'

" Search through file contents with silver searcher
Plug 'mileszs/ack.vim'
" Find files by name with fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

""" Editing

" Keep latest yank
Plug 'maxbrunsfeld/vim-yankstack'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'

" Go to file (gf)
Plug 'amix/open_file_under_cursor.vim'

" Match opening brackets automatically
Plug 'Raimondi/delimitMate'

" Surround selection with any character
Plug 'tpope/vim-surround'

" Search with asterisk
Plug 'thinca/vim-visualstar'

" Toggle comment (gcc)
Plug 'tpope/vim-commentary'

" Expand/collapse regions (zR)
Plug 'terryma/vim-expand-region'

" Show indentation levels
Plug 'nathanaelkane/vim-indent-guides'

""" Languages & File Formats

" ALE already covers many languages
Plug 'dense-analysis/ale'

" Asciidoc
Plug 'habamax/vim-asciidoctor'

" CSV
Plug 'mechatroner/rainbow_csv'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" Go
Plug 'fatih/vim-go'
" Hugo
Plug 'robertbasic/vim-hugo-helper'

" Helm
Plug 'towolf/vim-helm'

" Terraform
Plug 'hashivim/vim-terraform'

" Rust
Plug 'rust-lang/rust.vim'
" Cargo
Plug 'timonv/vim-cargo'

" Markdown shortcuts
Plug 'SidOfc/mkdx'

" Show Markdown preview in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Get yaml path of line under cursor
Plug 'lmeijvogel/vim-yaml-helper'

" Initialize plugin system
call plug#end()
