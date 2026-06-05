eval "$(/opt/homebrew/bin/brew shellenv)"

paths=(
  "$HOME/.local/bin"
  "$HOME/.bun/bin"
  "/opt/homebrew/opt/make/libexec/gnubin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  "/opt/homebrew/opt/grep/libexec/gnubin"
  "/opt/homebrew/opt/findutils/libexec/gnubin"
  "/opt/homebrew/opt/util-linux/bin"
  "/opt/homebrew/opt/util-linux/sbin"
  "/opt/homebrew/opt/llvm/bin"
  "/opt/homebrew/opt/binutils/bin"
  "/opt/homebrew/opt/node/bin"
  "/opt/homebrew/opt/go/bin"
  "/opt/homebrew/bin"
  "/Applications/Xcode.app/Contents/Developer/usr/bin"
  "/usr/local/sbin"
)

# Build PATH from array
# Loop through each path and prepend to create final PATH
NEW="${paths[1]}" && paths=("${paths[@]:1}")
for p in "${paths[@]}"; do
  NEW="$NEW:$p"
done
PATH="$NEW:$PATH"

# Optional: Environment-specific customizations

# Added by Antigravity CLI installer
export PATH="/Users/tamakiii/.local/bin:$PATH"
