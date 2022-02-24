" ALE
autocmd BufWritePost *.css,*.jsx,*.html,*.htm ALEFix
let g:ale_linters = {
\  'css': ['prettier'],
\  'dockerfile': ['hadolint'],
\  'javascript': ['eslint'],
\  'markdown': [''],
\  'go': ['go', 'golint', 'errcheck'],
\  'python': ['flake8'],
\  'scss' : ['prettier'],
\  'sh' : ['shellcheck'],
\  'xml' : ['xmllint'],
\  'yaml': ['yamllint'],
\  'zsh' : ['shellcheck'],
\}
let g:ale_fixers = {
\  'css': ['prettier'],
\  'html': ['prettier'],
\  'javascript': ['eslint'],
\  'json': ['jq'],
\  'python': ['yapf'],
\  'ruby': ['rubocop'],
\  'rust': ['rustfmt'],
\  'scss' : ['prettier'],
\  'sh': ['shfmt'],
\  'xml' : ['xmllint'],
\  'yaml': ['prettier'],
\}
nmap <silent> <leader>a <Plug>(ale_next_wrap)
" Disabling highlighting
let g:ale_set_highlights = 0
" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" let g:ale_fix_on_save = 1
map <leader>af :ALEFix<CR>

" Dockerfile
autocmd! BufNewFile,BufReadPost *Dockerfile* set filetype=Dockerfile

" Go
map <Leader>xg :GoRun<CR>

" Jenkinsfile
autocmd BufNewFile,BufRead *Jenkinsfile* setf groovy

" JSON
autocmd FileType json setlocal foldmethod=syntax

" Markdown
let vim_markdown_folding_disabled = 1
set foldlevel=20
autocmd! BufNewFile,BufReadPost *.{markdown,md} set filetype=markdown foldmethod=indent
autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab spell!
vmap <leader>l :HugoHelperLink 
let g:mkdp_preview_options = {
\ 'disable_sync_scroll': 1,
\ 'disable_filename': 1
\ }

" Nginx
au! BufNewFile,BufReadPost *.conf set filetype=nginx foldmethod=syntax

" Pandoc LaTeX
" let g:pandoc#command#latex_engine = "pdflatex"

" PHP
let g:php_folding=2
autocmd FileType php setlocal foldmethod=syntax

" Python
map <Leader>xp :!python %<CR>
let python_highlight_all = 1
autocmd FileType python syn keyword pythonDecorator True None False self
autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
autocmd FileType python map <buffer> F :set foldmethod=indent<cr>

" Ruby
autocmd FileType ruby setlocal foldmethod=syntax
" Rspec bindings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "term rspec --fail-fast #{spec}"

" Rust
map <Leader>xr :CargoRun<CR>

" Terraform
autocmd! BufNewFile,BufReadPost *.{tmpl} set filetype=json foldmethod=syntax
autocmd FileType terraform set foldmethod=syntax
let g:terraform_fmt_on_save=1

" Shell
map <leader>xs :!sh %<CR>
map <leader>xb :!bash %<CR>

" XML
let g:xml_syntax_folding=1
autocmd FileType xml,xslt,html setlocal foldmethod=syntax

" YAML
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
