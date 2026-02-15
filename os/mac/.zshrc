source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/aliases.zsh

umask 002
bindkey -e
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  PROMPT="$(echo -e '\U1F9F8') %M:%c
$ "
fi

autoload colors
colors

autoload -Uz compinit
compinit

autoload history-search-end
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups

export FZF_DEFAULT_OPTS="
  --preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || echo {}'
  --bind='ctrl-/:toggle-preview'
"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {} 2>/dev/null || echo {}'"
export FZF_ALT_C_OPTS="--preview 'ls -1 {}'"

source <(fzf --zsh 2>/dev/null) || true
