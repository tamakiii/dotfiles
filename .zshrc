# zsh
umask 002
bindkey -v
bindkey -e
HISTSIZE=1000000
SAVEHIST=1000000
SHELL=$(which zsh)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# export
export LANG="ja_JP.UTF-8"
export LANGUAGE="ja_JP:ja"
export LC_CTYPE="ja_JP.UTF-8"
export LC_NUMERIC="ja_JP.UTF-8"
export LC_TIME="ja_JP.UTF-8"
export LC_COLLATE="ja_JP.UTF-8"
export LC_MONETARY="ja_JP.UTF-8"
export LC_MESSAGES="ja_JP.UTF-8"
export LC_PAPER="ja_JP.UTF-8"
export LC_NAME="ja_JP.UTF-8"
export LC_ADDRESS="ja_JP.UTF-8"
export LC_TELEPHONE="ja_JP.UTF-8"
export LC_MEASUREMENT="ja_JP.UTF-8"
export LC_IDENTIFICATION="ja_JP.UTF-8"
export LC_ALL=
export LESSCHARSET="utf-8"

# colors
autoload colors
colors

# autoload
autoload history-search-end

# prompt
PROMPT="$(echo -e '\U1F9F8') %M:%c
$ "

# completion
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

autoload -Uz compinit
compinit
