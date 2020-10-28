" init
set all&
autocmd!

syntax on

language en_US.UTF-8
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,sjis,euc-jp,latin1
set noswapfile
set nobackup
set noundofile
set nowrap
set noerrorbells
set noshowmode
set nocompatible
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set iminsert=0
set imsearch=0
set clipboard=unnamed
set browsedir=current
set colorcolumn=80
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smartcase
set backspace=indent,eol,start
set number
set ruler
set cmdheight=1
set showmatch
set title
set matchtime=3
set splitright
set timeout timeoutlen=1000 ttimeoutlen=50
set ignorecase
if v:version > 730
  set wildignorecase
endif
set wildmenu
set wildmode=list:longest,full
set hlsearch
set incsearch

augroup Filetype
  autocmd!
  autocmd FileType php setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

let mapleader = ","

call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'tomtom/tcomment_vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'k0kubun/vim-open-github'
Plug 'vim-vdebug/vdebug'
Plug 'preservim/nerdtree'
call plug#end()

" vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nmap ?? :LspHover<cr>
nmap ?! :LspDocumentDiagnostics<cr>

" prabirshrestha/asyncomplete.vim
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" fzf.vim
let g:fzf_buffers_jump = 1
nmap <leader>p :Files<cr>
nmap <leader>P :Commands<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>g :GFiles<cr>
nmap <leader>g? :GFiles?<cr>

nmap <C-x>f <plug>(fzf-maps-n)
imap <C-x>f <plug>(fzf-maps-i)
xmap <C-x>f <plug>(fzf-maps-x)
omap <C-x>f <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Shortcuts
function! Esc()
  :let @/ = ""
  :call popup_clear()
endfunction

nmap ; :
nmap <esc><esc> :call Esc()<cr>
nmap <c-x>r :source $MYVIMRC<cr>

" color scheme
colorscheme SerialExperimentsLain
hi Normal ctermbg=NONE guibg=NONE
