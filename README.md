# dotfiles

## How to use

### macOS
```sh
# Install XCode
open "https://apps.apple.com/jp/app/xcode/id497799835?l=en&mt=12"

# Install Kensington Mouse Works
open "https://www.kensington.com/ja-jp/software/kensingtonworks/"

make setup
make install

# HomeBrew
make -f brew.mk diff
make -f brew.mk -B Brewfile
```

## SSH setup
```sh
# https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-add -K ~/.ssh/id_ed25519
```
