" Sync system clipboard
set clipboard+=unnamedplus

" Set default tab width
set tabstop=2
set softtabstop=2
set shiftwidth=2

" List all TODOs and similar tags
map <leader>do :vimgrep /# \(TODO<Bslash><Bar>FIXME\): / **/*<CR><leader>cc<CR>

" Handle base64 strings
vnoremap <leader>bd c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>be c<c-r>=system('base64', @")<cr><esc>

" Diffing
map <leader>dt :diffthis<CR>
map <leader>df :diffoff!<CR>

" Git
map <leader>gl :Git pull<CR>
nnoremap <leader>gL :Gclog!<CR>
map <leader>gp :Git push<CR>
map <leader>gP :Git push -f<CR>
" Last commit message to line
nnoremap <leader>lc :r!git log -1 --pretty=\%B \| head -n1<CR>

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

" Center search results in the middle of the screen
set scrolloff=10

" Wrap lines on whole words
set linebreak
