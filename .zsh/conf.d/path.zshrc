export GOPATH="$HOME/.go"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="$HOME/.dotfiles/node_modules/.bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/mysql@5.5/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="./node_modules/.bin:$PATH"

if type go 2>&1 > /dev/null; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi
