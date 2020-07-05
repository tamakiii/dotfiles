
"   Environments
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
let s:uname = system("echo -n \"$(uname)\"")
let s:hostname = system("echo -n \"$(hostname -s)\"")

"   Charsets
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,sjis,euc-jp,latin1

"   Editor & View
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set nowrap
set noerrorbells
set laststatus=2
set noshowmode
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set iminsert=0
set imsearch=0
set clipboard=unnamed
set browsedir=current

set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set number
set ruler
set cmdheight=1
set showmatch
set title
set matchtime=3
set splitright

"   Directories
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set backupdir=~/.vim/backup
set directory=~/.vim/swapfile
if v:version > 730
  set undodir=~/.vim/undo
endif

"   Search
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set ignorecase
if v:version > 730
  set wildignorecase
endif
set wildmenu
set wildmode=list:longest,full
set hlsearch
set incsearch

"   Keys
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
let mapleader = ","
noremap \ ,

"   Config by filetype
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
augroup Filetype
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"   vim-plug (https://github.com/junegunn/vim-plug)
"   `:PlugInstall` to install
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

call plug#begin('~/.vim/plugged')

Plug 'tomtom/tcomment_vim'
Plug 'lu-ren/SerialExperimentsLain'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

call plug#end()

"   Basics
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
syntax on
filetype on
filetype indent on
filetype plugin on

"   Shortcut
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap ; :
nmap <esc><esc> :noh<cr><esc>
nmap <leader><space> :noh<cr><esc>
nmap <leader>r<space> :source $MYVIMRC<cr>
nmap <leader>e<space> :e %<cr>

"   vim-plug (https://github.com/junegunn/vim-plug)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <leader>i<space> :PlugInstall<cr>

"   tcomment (https://github.com/tomtom/tcomment_vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <leader>c<space> :TComment<cr>
vmap <leader>c<space> :TComment<cr>

"   open-browser.vim (https://github.com/tyru/open-browser.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
vmap <leader>o<space> <plug>(openbrowser-open)

"   open-browser-github.vim (https://github.com/tyru/open-browser-github.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <leader>og<space> :'<,'>OpenGithubFile<cr>

"   fzf.vim (https://github.com/junegunn/fzf.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <leader><tab> <plug>(fzf-maps-n)
imap <leader><tab> <plug>(fzf-maps-i)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <leader>f<space> :Files!<cr>
nmap <leader>g<space> :GFiles<cr>
nmap <leader>gs<space> :GFiles!?<cr>
nmap <leader>b<space> :Buffers<cr>
" nmap <leader>ag<space> :call fzf#vim#ag_raw('--hidden --ignore .git -l -g ""')<cr>
nmap <leader>ag<space> :Ag!<cr>
nmap <leader>w<space> :Windows!<cr>
nmap <leader>h<space> :History:<cr>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"   Colorscheme
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
colorscheme SerialExperimentsLain
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

