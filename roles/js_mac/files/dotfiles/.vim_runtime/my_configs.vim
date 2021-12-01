" Open new buffers horizontally
set splitright
" Show line numbers
set number
" Set color scheme
colorscheme solarized
" let g:solarized_termcolors=256
set background=light
" highlight Normal ctermbg=NONE
" Status line color scheme
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }
" Position NerdTree left
let g:NERDTreeWinPos = "left"
" Open NerdTree sidebar on startup
autocmd VimEnter * NERDTreeToggle
" Open all folds when opening a file
autocmd BufWinEnter * silent! :%foldopen!
" Sync system clipboard
set clipboard=unnamed
" After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Set default tab width
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Linting
" let g:ale_fix_on_save = 1
autocmd BufWritePost *.css,*.jsx,*.html,*.htm ALEFix
let g:ale_linters = {
\  'css': ['prettier'],
\  'dockerfile': ['hadolint'],
\  'html': ['prettier'],
\  'javascript': ['eslint'],
\  'python': ['flake8'],
\  'scss' : ['prettier'],
\  'sh' : ['shellcheck'],
\  'xml' : ['xmllint'],
\  'yaml': ['yamllint'],
\}
let g:ale_fixers = {
\  'css': ['prettier'],
\  'html': ['prettier'],
\  'javascript': ['prettier'],
\  'json': ['jq'],
\  'python': ['yapf'],
\  'ruby': ['rubocop'],
\  'rust': ['rustfmt'],
\  'scss' : ['prettier'],
\  'sh': ['shfmt'],
\  'xml' : ['xmllint'],
\  'yaml': ['prettier'],
\}

" Vim Plugins
let g:snipMate = { 'snippet_version' : 1 }
set rtp+=/usr/local/opt/fzf

" Nginx
au! BufNewFile,BufReadPost *.conf set filetype=nginx foldmethod=syntax

" Dockerfile
au! BufNewFile,BufReadPost *Dockerfile* set filetype=Dockerfile

" Go
map <Leader>xg :GoRun<CR>
" let g:go_fmt_autosave = 1

" Jenkinsfile
au BufNewFile,BufRead *Jenkinsfile* setf groovy

" JSON
au FileType json setlocal foldmethod=syntax

" Markdown
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 4
" let g:vim_markdown_new_list_item_indent = 0
" let g:pandoc#filetypes#pandoc_markdown = 0
set foldlevel=20
au! BufNewFile,BufReadPost *.{markdown,md} set filetype=markdown foldmethod=indent
autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab spell!
vmap <leader>l :HugoHelperLink 

" Nginx
" au! BufNewFile,BufReadPost *.conf set filetype=nginx foldmethod=syntax

" Pandoc LaTeX
" let g:pandoc#command#latex_engine = "pdflatex"

" PHP
let g:php_folding=2
autocmd FileType php setlocal foldmethod=syntax

" Python
map <Leader>xp :!python %<CR>

" Ruby
au FileType ruby setlocal foldmethod=syntax
" Rspec bindings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "term rspec --fail-fast #{spec}"
let g:reek_on_loading = 0
let g:reek_always_show = 0

" Rust
map <Leader>xr :CargoRun<CR>

" Terraform
au! BufNewFile,BufReadPost *.{tmpl} set filetype=json foldmethod=syntax
autocmd FileType terraform set foldmethod=syntax
let g:terraform_fmt_on_save=1

" XML
let g:xml_syntax_folding=1
autocmd FileType xml,xslt,html setlocal foldmethod=syntax

" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Custom keybindings
" List all TODOs and similar tags
map <Leader>do :vimgrep /# \(TODO<Bslash><Bar>FIXME\): / **/*<CR><Leader>cc<CR>
" Activate Limelight when entering Goyo mode
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
let g:ackprg = 'ag --nogroup --nocolor --column'
" Comfortably decode base64 strings
vnoremap <leader>bd c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>be c<c-r>=system('base64', @")<cr><esc>
" Diffing
map <Leader>dt :diffthis<CR>
map <Leader>df :diffoff!<CR>
" Git
map <Leader>gl :Git pull<CR>
nnoremap <Leader>gL :Gclog!<CR>
map <Leader>gp :Git push<CR>
map <Leader>gP :Git push -f<CR>
" ALEFix
map <Leader>af :ALEFix<CR>
" Shell
map <Leader>xs :!sh % > out.log<CR>
map <Leader>xb :!bash % > out.log<CR>


" Copy current file name (relative/absolute) to system clipboard
" https://stackoverflow.com/a/17096082/6435726
" Relative path (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>
" Absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>
" Filename (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t")<CR>
" Directory name (/something/src)
nnoremap <leader>ch :let @+=expand("%:p:h")<CR>
