# tmux pane layouts

## ASCII representation

```
┌─┬──┐
│ │  │
├─┴──┤
│    │
├─┬──┤
└─┴──┘
```

## Split horizontally

```sh
tmux split-window -h
# or prefix + %
```

## Split vertically

```sh
tmux split-window -v
# or prefix + "
```

## Navigate panes

```sh
# prefix + arrow keys
# or
tmux select-pane -U  # up
tmux select-pane -D  # down
tmux select-pane -L  # left
tmux select-pane -R  # right
```

## Resize panes

```sh
# prefix + Ctrl + arrow keys
# or
tmux resize-pane -U 5
tmux resize-pane -D 5
tmux resize-pane -L 5
tmux resize-pane -R 5
```

## Preset layouts

```sh
tmux select-layout even-horizontal
tmux select-layout even-vertical
tmux select-layout main-horizontal
tmux select-layout main-vertical
tmux select-layout tiled
# or prefix + space to cycle through layouts
```

## Close pane

```sh
exit
# or prefix + x
```
