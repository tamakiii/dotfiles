source ~/.zsh/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

umask 002
bindkey -v
bindkey -e
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
PROMPT="$(echo -e '\U1F9F8') %M:%c
$ "

autoload colors
colors

autoload -Uz compinit
compinit

autoload history-search-end
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
setopt share_history
setopt incappendhistory
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

# Wrap `claude` with frequently-used --add-dir paths, and provide the launcher
# that loads the Figma plugin only when it is asked for. Both are defined in the
# private half of the dotfiles tree (tamakiii/myfiles), which installs the file
# to the path below. Origin: tamakiii/meta#276.
[[ -f ~/.local/lib/shell/claude.zsh ]] && source ~/.local/lib/shell/claude.zsh

# Put ~/.local/bin on PATH for interactive shells that are not login shells.
# `.zprofile` builds the whole PATH but only login shells read it, so a plain
# interactive zsh started from a bare environment does not get this directory.
# The script is uv's, it is idempotent, and it is a no-op once .zprofile has
# already run. Carried here from the live ~/.zshrc, where an installer had
# written it — see tamakiii/meta#2388.
[[ -f ~/.local/bin/env ]] && source ~/.local/bin/env
