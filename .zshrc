source ~/.zplug/init.zsh

zplug "plugins/git", from:"oh-my-zsh"
zplug "plugins/pip", from:"oh-my-zsh"
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "sindresorhus/pure", from:"github", use:"pure.zsh", as:"theme"
zplug "docker/compose", from:"github", use:"contrib/completion/zsh"
zplug "felixr/docker-zsh-completion", from:"github"
zplug "zsh-users/zsh-completions", from:"github"
zplug "zsh-users/zsh-autosuggestions", from:"github", on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", from:"github", on:"zsh-users/zsh-autosuggestions"

# pure
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL="$"
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

# colors
autoload colors
colors

# autoload
autoload history-search-end

# source another zshrc
source ~/.zsh/conf.d/path.zshrc
source ~/.zsh/conf.d/alias.zshrc
source ~/.zsh/conf.d/export.zshrc
source ~/.zsh/conf.d/setopt.zshrc
source ~/.zsh/conf.d/zstyle.zshrc
source ~/.zsh/conf.d/function.zshrc
source ~/.zsh/conf.d/tmux.zshrc
source ~/.zsh/conf.d/npm.zshrc
source ~/.zsh/conf.d/bindkey.zshrc

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load # --verbose
