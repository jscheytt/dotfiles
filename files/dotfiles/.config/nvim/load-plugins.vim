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
Plug 'ishan9299/nvim-solarized-lua'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File Tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Buffer Management (leader+o)
Plug 'vim-scripts/bufexplorer.zip'

" Search through file contents with silver searcher
Plug 'mileszs/ack.vim'
" Find files by name with fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

" " Coding assistant
" Plug 'nvim-lua/plenary.nvim'
" Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }

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

" Auto-completion (mostly for LaTeX)
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" Project-specific vimrc
Plug 'embear/vim-localvimrc'

""" Languages & File Formats

" ALE already covers many languages
Plug 'dense-analysis/ale'

" Asciidoc
Plug 'habamax/vim-asciidoctor'

" CSV
Plug 'mechatroner/rainbow_csv'

" Cuelang
Plug 'jjo/vim-cue'

" D2
Plug 'terrastruct/d2-vim'

" Earthly/Earthfile
Plug 'earthly/earthly.vim', { 'branch': 'main' }

" Go
Plug 'fatih/vim-go'
" Hugo
Plug 'robertbasic/vim-hugo-helper'

" Helm
Plug 'towolf/vim-helm'

" LaTeX
Plug 'lervag/vimtex'
" Add snippets (e.g. figures, environments)
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Show Markdown preview in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Terraform
Plug 'hashivim/vim-terraform'

" Rust
Plug 'rust-lang/rust.vim'
" Cargo
Plug 'timonv/vim-cargo'

" YAML
" Folding
Plug 'pedrohdz/vim-yaml-folds'

" Initialize plugin system
call plug#end()
