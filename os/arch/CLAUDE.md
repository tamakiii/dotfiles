# CLAUDE.md - Arch Linux Configuration

This file provides guidance to Claude Code when working with Arch Linux-specific configurations in this dotfiles repository.

## Hyprland Configuration

### Config File Location
- Main config: `os/arch/.config/hypr/hyprland.conf`
- Wallpaper config: `os/arch/.config/hypr/hyprpaper.conf`

### Config Error Display

**Important**: Hyprland configuration errors are displayed as **on-screen notifications**, not in terminal output or journalctl.

When you reload the config with `hyprctl reload` or start Hyprland, syntax errors appear as pop-up notifications on your screen showing:
```
Config error in file /path/to/hyprland.conf at line X: <error message>
```

### Hyprland Logs Location

Logs are stored in dynamic runtime directories:
```bash
# Current session log location
$XDG_RUNTIME_DIR/hypr/<instance-signature>/hyprland.log

# Typical path
/run/user/1000/hypr/<hash>/hyprland.log

# Find current log
ls -t $XDG_RUNTIME_DIR/hypr/*/hyprland.log | head -1

# View current log
cat $(ls -t $XDG_RUNTIME_DIR/hypr/*/hyprland.log | head -1)

# Follow live
tail -f $(ls -t $XDG_RUNTIME_DIR/hypr/*/hyprland.log | head -1)
```

The instance signature (hash) changes with each Hyprland session, so the path is not static.

### Enable Debug Logging

By default, Hyprland disables detailed logs. Enable them in `hyprland.conf`:

```conf
debug {
    disable_logs = false
}
```

After enabling, logs will show detailed config parsing and runtime information.

### Common Config Syntax Updates (Hyprland 0.51+)

#### Window Rules
```diff
# Old syntax (deprecated)
- windowrule = float, ^(pavucontrol)$

# New syntax (windowrulev2)
+ windowrulev2 = float, class:^(pavucontrol)$
```

#### Shadow Configuration
```diff
# Old syntax (deprecated)
- drop_shadow = yes
- shadow_range = 4
- shadow_render_power = 3
- col.shadow = rgba(1a1a1aee)

# New syntax (nested block)
+ shadow {
+     enabled = yes
+     range = 4
+     render_power = 3
+     color = rgba(1a1a1aee)
+ }
```

#### Gestures (Workspace Swipe)
```diff
# Old syntax (removed in 0.51)
- workspace_swipe = on

# New syntax (gesture-based)
+ gesture = 3, horizontal, workspace
+ workspace_swipe_distance = 700
+ workspace_swipe_invert = false
```

### Troubleshooting

1. **Config errors not in journalctl**: Use on-screen notifications or enable debug logging
2. **Can't find logs**: Check `$XDG_RUNTIME_DIR/hypr/*/hyprland.log` (not `/var/log` or `/tmp`)
3. **Deprecated options**: Check Hyprland wiki for version-specific syntax changes
4. **hyprctl connection failed**: Ensure `$HYPRLAND_INSTANCE_SIGNATURE` matches current session

### Useful Commands

```bash
# Reload config
export HYPRLAND_INSTANCE_SIGNATURE=$(ls -t /run/user/1000/hypr/*/.socket.sock | head -1 | xargs dirname | xargs basename)
hyprctl reload

# Check version
hyprctl version

# List active window rules
hyprctl windowrules

# Monitor current workspace
hyprctl monitors
```

## Waybar Configuration

- Config: `os/arch/.config/waybar/config`
- Styles: `os/arch/.config/waybar/style.css`
- Theme: Catppuccin-inspired colors

## Installation

```bash
# Install OS-specific configs
make -C os/arch install

# Check dependencies
make -C os/arch check-dependency

# Verify installation
make -C os/arch check
```

## Dependencies

Required packages for Hyprland setup:
- `hyprland` - Wayland compositor
- `waybar` - Status bar
- `hyprpaper` - Wallpaper daemon
- `grim` - Screenshot utility
- `slurp` - Screen area selection
- `wl-clipboard` - Clipboard utilities
- `brightnessctl` - Brightness control

See `os/arch/Makefile` check-dependency target for full list.
