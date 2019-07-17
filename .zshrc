fpath=(/usr/local/share/zsh/functions ${fpath})

### Added by Zplugin's installer
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light "mafredri/zsh-async"
zplugin light "sindresorhus/pure"
zplugin light "zsh-users/zsh-completions"
zplugin light "zsh-users/zsh-autosuggestions"
zplugin light "zsh-users/zsh-syntax-highlighting"

# pure
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL="$"
HISTFILE=$HOME/.zsh_history

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
source ~/.zsh/conf.d/function.zshrc
source ~/.zsh/conf.d/tmux.zshrc
source ~/.zsh/conf.d/npm.zshrc
source ~/.zsh/conf.d/bindkey.zshrc
source ~/.zsh/conf.d/completion.zshrc
