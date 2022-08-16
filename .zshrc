# antigen
source ~/.zsh/antigen.zsh

# antigen
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# general
umask 002
bindkey -v
bindkey -e
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# lang
export LANG="en_US.UTF-8"
export LANGUAGE="en_US"

# colors
autoload colors
colors

# autoload
autoload history-search-end

# prompt
PROMPT="$(echo -e '\U1F9F8') %M:%c
$ "

# history
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt hist_ignore_dups
