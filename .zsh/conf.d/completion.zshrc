zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

autoload -Uz compinit
compinit
