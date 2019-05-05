# http://zsh.sourceforge.net/Doc/Release/zsh_17.html
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

if type peco 2>&1 > /dev/null; then
  function peco-history-selection() {
    BUFFER=`history -nr 1 | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
  }
  zle -N peco-history-selection
  bindkey '^R' peco-history-selection
fi
