
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
set complete+=k
set complete+=i
set complete+=w
set complete+=w
set complete+=t
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
nmap <ESC><ESC> :noh<CR><ESC>         " <ESC>二度押しで検索ハイライト解除
nmap ,h ^
nmap ,l $
nmap <C-w>t :tabnew<ESC>
imap <C-w>t <Esc>:tabnew<ESC>
nmap <C-w>\| :vnew<ESC>
imap <C-w>\| <Esc>:vnew<ESC>

"   Fix runtimepath
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set runtimepath+=/usr/local/share/vim/vim81

"   deni.vim (https://github.com/Shougo/dein.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if &compatible
  set nocompatible
endif

set runtimepath+=$HOME/.vim/dein.vim

if dein#load_state("$HOME/.vim")
  call dein#begin("$HOME/.vim")
  call dein#add("$HOME/.vim/dein.vim")

  call dein#add('shougo/neosnippet.vim')
  call dein#add('shougo/neosnippet-snippets')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('kyuhi/vim-emoji-complete')
  call dein#add('junegunn/fzf.vim')

  call dein#add('tomasr/molokai')
  call dein#add('yuttie/hydrangea-vim')
  call dein#add('lu-ren/SerialExperimentsLain')
  call dein#add('hashivim/vim-hashicorp-tools')
  call dein#add('b4b4r07/vim-hcl')
  call dein#add('vim-scripts/nginx.vim')
  call dein#add('leafgarland/typescript-vim')

  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"   tcomment (https://github.com/tomtom/tcomment_vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
nmap <Leader>c<space> :TComment<CR>
vmap <Leader>c<space> :TComment<CR>

"   vim-emoji-complete (https://github.com/kyuhi/vim-emoji-complete)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" imap <C-x><C-e> <Plug>(emoji-start-complete)

"   fzf.vim (https://github.com/junegunn/fzf.vim)
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set runtimepath+=~/.fzf

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nmap <leader>f :FZF<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"   Basics
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
syntax on
filetype on
filetype indent on
filetype plugin on

"   Colorscheme
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" set t_Co=256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" let g:solarized_termtrans = 1
" colorscheme desert
" colorscheme hydrangea
colorscheme SerialExperimentsLain
