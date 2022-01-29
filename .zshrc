# zsh
emulate -LR zsh
umask 002
bindkey -v
bindkey -e
HISTSIZE=1000000
SAVEHIST=1000000
SHELL=$(which zsh)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# export
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:us"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL=
export LESSCHARSET="utf-8"

# paths
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.symfony/bin:$PATH"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export PATH="$PATH:$HOME/Library/Android/sdk/emulator"

# google-cloud-sdk
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Editor
export VISUAL=$(which vim)
export EDITOR=$(which vim)

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

# # golang
# GOPATH=$HOME/go

# fzf
if [[ -x "$(command -v rg)" ]]; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
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
