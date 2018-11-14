source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "zsh-users/zsh-completions"
zplug "docker/compose", use:contrib/completion/zsh
zplug "felixr/docker-zsh-completion"
zplug "mollifier/anyframe"

# pure
PURE_GIT_PULL=0
HISTFILE=~/.zsh_history

# zsh
umask 002
bindkey -v
bindkey -e
HISTSIZE=1000000
SAVEHIST=1000000
SHELL=$(which zsh)
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# export
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP:ja
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
export LESSCHARSET=utf-8

# setopt
setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt cdable_vars sh_word_split auto_param_keys
setopt auto_pushd
setopt list_packed
setopt nolistbeep
setopt complete_aliases
setopt share_history        # share command history data
setopt hist_ignore_all_dups hist_reduce_blanks hist_no_store print_eight_bit
setopt prompt_subst
stty stop undef

# bindkey
# http://zsh.sourceforge.net/Doc/Release/zsh_17.html
autoload history-search-end
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

# colors
autoload colors
colors

# anyframe
fpath+=($HOME/.zplug/repos/mollifier/anyframe(N-/))
autoload -Uz anyframe-init && anyframe-init

# source another zshrc
source ~/.zsh/conf.d/path.zshrc
source ~/.zsh/conf.d/alias.zshrc
source ~/.zsh/conf.d/export.zshrc
source ~/.zsh/conf.d/setopt.zshrc
source ~/.zsh/conf.d/zstyle.zshrc
source ~/.zsh/conf.d/function.zshrc
source ~/.zsh/conf.d/tmux.zshrc
source ~/.zsh/conf.d/npm.zshrc
source ~/.zsh/conf.d/anyenv.zshrc
source ~/.zsh/conf.d/keybind.zshrc

PROMPT="$ "

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load # --verbose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fix: (eval):setopt:3: no such option: NO_warnnestedvar
_comp_options="${_comp_options/NO_warnnestedvar/}"
