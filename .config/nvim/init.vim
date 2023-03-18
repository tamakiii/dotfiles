set number

map x ^v$
map gl $
map gh ^
map gn gt
map gp gT
map <C-c> :TComment<CR>

let mapleader = " "

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'bronson/vim-trailing-whitespace'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'tomtom/tcomment_vim'
call plug#end()
