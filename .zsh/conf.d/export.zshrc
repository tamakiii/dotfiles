export EDITOR=$(which vim)

if type src-hilite-lesspipe.sh 2>&1 > /dev/null; then
  export LESS='-R'
  export LESSOPEN='| src-hilite-lesspipe.sh %s'
fi
