
"   Environments
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
let s:uname = system("echo -n \"$(uname)\"")
let s:hostname = system("echo -n \"$(hostname -s)\"")

"   Charsets
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,sjis,euc-jp,latin1
language en_US.UTF-8

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
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

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
nmap <leader>w<space> :Windows!<cr>

nmap <leader>h<space> :History:<cr>
nmap <leader>co<space> :Commands!<cr>
nmap <leader>ag<space> :Ag!<cr>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"   vim-lsp (https://github.com/prabirshrestha/vim-lsp)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nmap <leader>?<space> :LspHover<cr>
nmap ?? :LspHover<cr>

nmap <leader>ref<space> :LspReference<cr>
nmap <leader>rename<space> :LspRename<cr>
nmap <leader>stat<space> :LspStatus<cr>
nmap <leader>status<space> :LspStatus<cr>

nmap <leader>error<space> :LspNextError<cr>
nmap <leader>en<space> :LspNextError<cr>
nmap <leader>ep<space> :LspPreviousError<cr>

nmap <leader>warn<space> :LspNextWarning<cr>
nmap <leader>warning<space> :LspNextWarning<cr>
nmap <leader>wn<space> :LspNextWarning<cr>
nmap <leader>wp<space> :LspPreviousWarning<cr>

nmap <leader>def<space> :LspDefinition<cr>
nmap <leader>dec<space> :LspDeclaration<cr>
nmap <leader>decl<space> :LspDeclaration<cr>
nmap <leader>impl<space> :LspImplementation<cr>
nmap <leader>type<space> :LspTypeDefinition<cr>
nmap <leader>diag<space> :LspDocumentDiagnostics<cr>

nmap <leader>def? :LspPeekDefinition<cr>
nmap <leader>dec? :LspPeekDeclaration<cr>
nmap <leader>decl? :LspPeekDeclaration<cr>
nmap <leader>impl? :LspPeekImplementation<cr>
nmap <leader>type? :LspPeekTypeDefinition<cr>
nmap <leader>diag? :LspDocumentDiagnostics<cr>

"   Colorscheme
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
colorscheme SerialExperimentsLain
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE

