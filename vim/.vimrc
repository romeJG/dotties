"Compatibility to Vim only
set nocompatible

"Set relative number
set relativenumber

"set tabstop
set tabstop=4

"set auto indent
set autoindent

"enable mouse
set mouse=a

" Automatically wrap text that extends beyond the screen length
set wrap

" Encoding
set encoding=utf-8

" Show Line Numbers
set number

" Status bar
set laststatus=2

" Call the .vimrc.plug file
if filereadable (expand("~/.vimrc.plug"))

" open nerd tree automatically
autocmd VimEnter * NERDTree
endif
" Shortcut on Split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j 
map <C-k> <C-w>k
map <C-l> <C-w>l

vmap <Tab> >
vmap <S-Tab> <
