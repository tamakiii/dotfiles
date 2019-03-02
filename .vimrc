
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

"   Shortcut
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap ; :
nmap <ESC><ESC> :noh<CR><ESC>

"   vim-plug (https://github.com/junegunn/vim-plug)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" :PlugInstall to install
call plug#begin('~/.vim/plugged')

Plug 'lu-ren/SerialExperimentsLain'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

call plug#end()

"   typescript-language-server (https://github.com/prabirshrestha/vim-lsp/wiki/Servers-TypeScript)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif

"   Basics
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
syntax on
filetype on
filetype indent on
filetype plugin on

"   Colorscheme
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
colorscheme SerialExperimentsLain
