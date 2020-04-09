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

# # http://zsh.sourceforge.net/Doc/Release/zsh_17.html
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey '^R' history-incremental-pattern-search-backward
# bindkey '^S' history-incremental-pattern-search-forward
# bindkey "^P" history-beginning-search-backward-end
# bindkey "^N" history-beginning-search-forward-end
# bindkey '^F' forward-char
# bindkey '^B' backward-char
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line

# fzf
function fzf-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N fzf-history
bindkey '^r' fzf-history

export FZF_TMUX_HEIGHT="40%"
export FZF_LEGACY_KEYBINDINGS=1
export FZF_PREVIEW_FILE_CMD="head -n 10"
export FZF_PREVIEW_DIR_CMD="ls"
export FZF_DEFAULT_OPTS="
  --no-height
  --layout=reverse
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
"
