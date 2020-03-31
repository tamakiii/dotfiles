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
export FZF_DEFAULT_OPTS="--height 100% --layout=reverse --color=bw"
export FZF_PREVIEW_FILE_CMD="head -n 10"
export FZF_PREVIEW_DIR_CMD="ls -lsa"
export FZF_LEGACY_KEYBINDINGS=0

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
