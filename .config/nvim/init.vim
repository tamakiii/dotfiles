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
Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
call plug#end()

lua <<EOF
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"}
})
EOF

