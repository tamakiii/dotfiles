export LANG="en_US.UTF-8"
export LANGUAGE="en_US"

eval "$(/opt/homebrew/bin/brew shellenv)"

paths=(
  "/usr/local/sbin"
  "$HOME/.dotfiles/node_modules/.bin"
  "bin"
  ".venv/bin"
  "/opt/homebrew/opt/make/libexec/gnubin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  "/opt/homebrew/opt/grep/libexec/gnubin"
  "/opt/homebrew/opt/findutils/libexec/gnubin"
  "/opt/homebrew/opt/util-linux/bin"
  "/opt/homebrew/opt/util-linux/sbin"
  "/opt/homebrew/opt/llvm/bin"
  "/opt/homebrew/opt/binutils/bin"
  "/opt/homebrew/opt/node@22/bin"
  "/opt/homebrew/opt/go/bin"
  "/opt/homebrew/bin"
  "$HOME/.dotfiles/bin"
  "$HOME/.dotfiles/node_modules/.bin"
  "$HOME/.dotcommands/bin"
  "$HOME/.dotcommands/command/bin"
  "$HOME/.venv/bin"
  "$HOME/Library/Application Support/Coursier/bin"
  "$HOME/go/bin"
  "/Applications/Xcode.app/Contents/Developer/usr/bin"
)

NEW="${paths[1]}" && paths=("${paths[@]:1}")
for p in "${paths[@]}"; do
  NEW="$NEW:$p"
done
PATH="$NEW:$PATH"
