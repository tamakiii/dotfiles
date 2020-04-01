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

export FZF_COMPLETION_TRIGGER="??"
export FZF_COMPLETION_OPTS="+c -x"
export FZF_PREVIEW_FILE_CMD="head -n 10"
export FZF_PREVIEW_DIR_CMD="ls -lsa"
export FZF_LEGACY_KEYBINDINGS=0
# export FZF_COMPLETION_TRIGGER=''
# export FZF_TMUX=1

export FZF_DEFAULT_OPTS="
  --no-height
  --layout=reverse
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
"

stty werase undef
bind '\C-w:unix-filename-rubout'

bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/' | sed 's/"$/\\C-m"/')"

# bindkey '^T' fzf-completion
# bindkey '^I' $fzf_default_completion
#
# function select-history() {
#   BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
#     CURSOR=$#BUFFER
#   }
# zle -N select-history
# bindkey '^r' select-history

# source ~/.bash/plugin/fzf-tab-completion/bash/fzf-bash-completion.sh
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bind -x '"\t": fzf_bash_completion'

# export PS1="\w $ "
export PS1="$(echo -e '\U1F9F8') \h:\W \n$ "
# export PS1='\ek\e\\'"$(echo -e '\U1F9F8') \h:\W\$ "
# export PS1='\[\ek\e\\\][\u@\h \W]\$ '
# PS1=$(echo -e '\U1F9F8')' [\u@\h \W]\$ '

set show-all-if-ambiguous on
set show-all-if-unmodified on
set menu-complete-display-prefix on
bind '"\t": menu-complete'
bind '"\e[Z": menu-complete-backward'

# bind '"\e[6~": menu-complete'
# bind '"\e[5~": menu-complete-backward'
# bind 'TAB':menu-complete

# # Display a list of the matching files
#
# bind "set show-all-if-ambiguous on"
#
# # Perform partial completion on the first Tab press,
# # only start cycling full results on the second Tab press
#
# bind "set menu-complete-display-prefix on"
