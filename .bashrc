export PATH="/usr/local/bin:$PATH"

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

export FZF_DEFAULT_OPTS="
  --height 100%
  --layout=reverse
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
