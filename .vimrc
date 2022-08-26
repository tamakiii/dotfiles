" init
autocmd!

syntax on

" set
set noswapfile
set nobackup
set noundofile
set number
set backspace=indent,eol,start
set clipboard+=unnamed
set hlsearch
set autoindent
set smartindent

" let
let mapleader = ","

" vim-plug
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" fzf.vim
let g:fzf_buffers_jump = 1
nmap <leader>f :Files<cr>
nmap <leader>c :Commands<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>g :GFiles<cr>
nmap <leader>g? :GFiles?<cr>
nmap <leader>m :Maps<cr>
nmap <leader>h :History:<cr>
nmap <leader>/ :Rg<cr>

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
