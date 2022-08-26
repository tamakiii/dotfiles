# antigen
source ~/.zsh/antigen.zsh

# antigen
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
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

# completion
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# compinit
autoload -Uz compinit
compinit

# history
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt histignorealldups

function fzf-history() {
  BUFFER=$(history -n 1 | fzf --exact --no-sort +m --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N fzf-history
bindkey '^r' fzf-history
