
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

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'natebosch/vim-lsc'

Plug 'lu-ren/SerialExperimentsLain'
Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
Plug 'tomtom/tcomment_vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

"   typescript-language-server (https://github.com/prabirshrestha/vim-lsp/wiki/Servers-TypeScript)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
augroup LspTypeScript
  au!
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
  autocmd FileType typescript setlocal omnifunc=lsp#complete
augroup END

augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['golsp']},
        \ 'whitelist': ['go'],
        \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
  autocmd FileType python,go nmap gd <plug>(lsp-definition)
augroup END

augroup LspPhp
  au!
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'php-language-server',
        \ 'cmd': {server_info->['php', expand('~/.vim/plugged/php-language-server/bin/php-language-server.php')]},
        \ 'whitelist': ['php'],
        \ })
  au User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->['node', expand('~/.dotfiles/node_modules/intelephense/lib/intelephense.js'), '--stdio']},
        \ 'initialization_options': {"storagePath": "/tmp/intelephense"},
        \ 'whitelist': ['php'],
        \ })
  autocmd FileType php setlocal omnifunc=lsp#complete
augroup END

let g:lsp_async_completion = 0

"   Basics
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
syntax on
filetype on
filetype indent on
filetype plugin on

"   asyncomplete.vim (https://github.com/prabirshrestha/asyncomplete.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1

"   tcomment (https://github.com/tomtom/tcomment_vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <Leader>c<space> :TComment<CR>
vmap <Leader>c<space> :TComment<CR>

"   fzf.vim (https://github.com/junegunn/fzf.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set runtimepath+=~/.fzf

" Mapping selecting mappings
nmap <leader>f :FZF<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"   Colorscheme
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
colorscheme SerialExperimentsLain
