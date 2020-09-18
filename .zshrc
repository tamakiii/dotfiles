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
export PATH="/usr/local/opt/llvm/bin:$PATH"

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

# autosuggestion
source ~/.zsh/vendor/autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf
if [[ -x "$(command -v ag)" ]]; then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
else
  export FZF_DEFAULT_COMMAND='find .'
fi
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

# History
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks

function fzf-history() {
  BUFFER=$(history -n 1 | fzf --exact --no-sort +m --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort --query "$LBUFFER")
  CURSOR=$#BUFFER
}
zle -N fzf-history
bindkey '^r' fzf-history
