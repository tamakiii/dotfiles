" init
autocmd!

syntax on

" set
set noswapfile
set nobackup
set noundofile
set number

" let
let mapleader = ","

" vim-plug
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'lu-ren/SerialExperimentsLain'
call plug#end()

" Shortcuts
function! Esc()
  :let @/ = ""
  :call popup_clear()
endfunction

" nmap
nmap <esc><esc> :call Esc()<cr>

" color scheme
silent! colorscheme SerialExperimentsLain
hi Normal ctermbg=NONE guibg=NONE
