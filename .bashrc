export PATH="/usr/local/bin:$PATH"
export PATH="~/.local/bin:$PATH"

export LANG=""
export LC_COLLATE="ja_JP.UTF-8"
export LC_CTYPE="ja_JP.UTF-8"
export LC_MESSAGES="ja_JP.UTF-8"
export LC_MONETARY="ja_JP.UTF-8"
export LC_NUMERIC="ja_JP.UTF-8"
export LC_TIME="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_COMPLETION_TRIGGER="??"
export FZF_COMPLETION_OPTS="+c -x"
export FZF_PREVIEW_FILE_CMD="head -n 10"
export FZF_PREVIEW_DIR_CMD="ls -lsa"
export FZF_LEGACY_KEYBINDINGS=0
export FZF_TMUX=0

export FZF_DEFAULT_OPTS="
  --no-height
  --layout=reverse
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
"

function history-fzf() {
  READLINE_LINE=$(history | tac | fzf --query "$LBUFFER")
  READLINE_POINT=$#READLINE_LINE
}

stty werase undef

export PS1="$(echo -e '\U1F9F8') \h:\W \n$ "
export HISTCONTROL=ignoreboth:erasedups

bind "set show-all-if-ambiguous on"
bind "set show-all-if-unmodified on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"

bind    "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/' | sed 's/"$/\\C-m"/')"
bind    '"\t": menu-complete'
bind    '"\e[Z": menu-complete-backward'
bind    '"\C-w": unix-filename-rubout'
bind -x '"\C-r": history-fzf'
