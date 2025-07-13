# Arch Linux Configuration Guide

This document provides Arch Linux-specific guidance for Claude Code when working with this dotfiles repository on Arch Linux systems.

## Package Management

### Core Package Manager - pacman

```bash
# Update system
sudo pacman -Syu

# Install packages
sudo pacman -S package-name

# Search for packages
pacman -Ss search-term

# Query installed packages
pacman -Q
pacman -Qs search-term

# Check package info
pacman -Si package-name  # From repository
pacman -Qi package-name  # Installed package

# Remove packages
sudo pacman -R package-name
sudo pacman -Rdd package-name  # Force remove without dependency checks
```

### AUR Helper - yay

```bash
# Install from AUR
yay -S package-name

# Update all packages including AUR
yay -Syu
```

## Bluetooth Stack Configuration

### Required Packages

```bash
# Core bluetooth stack
sudo pacman -S bluez bluez-libs bluez-utils

# Additional functionality
sudo pacman -S bluez-obex  # File transfer support

# GUI frontends (choose one)
sudo pacman -S gnome-bluetooth-3.0  # GNOME (not legacy gnome-bluetooth)
sudo pacman -S bluedevil           # KDE
sudo pacman -S blueman             # GTK-based
```

### Audio Support

- **PipeWire**: Bluetooth support is built-in (no separate package needed)
- **PulseAudio**: Install `pulseaudio-bluetooth`

### Service Management

```bash
# Enable and start bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Check status
systemctl status bluetooth

# Restart after updates
sudo systemctl daemon-reload
sudo systemctl restart bluetooth
```

### Bluetooth Troubleshooting (Pairing Issues)

Common symptoms on Arch Linux systems:
- GNOME Settings detects devices but shows "Not Set Up" status
- Clicking devices in Settings doesn't complete pairing
- bluetoothctl shows `org.bluez.Error.AuthenticationCanceled`
- Devices connect briefly then disconnect immediately

**Root Causes:**
- Authentication timing issues between GUI and bluetoothd
- Missing or inactive Bluetooth agent for handling pairing requests
- Audio profile availability problems with PipeWire
- Device-specific pairing protocols (especially Sony devices)

### Diagnostic Commands

Essential commands for Bluetooth troubleshooting:

```bash
# Check Bluetooth service status
systemctl status bluetooth.service

# Verify Bluetooth adapter status
bluetoothctl show

# List all discovered devices
bluetoothctl devices

# Check specific device information
bluetoothctl info <MAC_ADDRESS>

# Check audio system status
systemctl --user status pipewire-pulse

# Verify installed Bluetooth packages
pacman -Q | grep -E "(blue|pulse)"
```

### Pairing Process Troubleshooting

**Step 1: Agent Management**
```bash
# Start Bluetooth agent
bluetoothctl agent on
bluetoothctl default-agent
```

**Step 2: Device Cache Clearing**
```bash
# Remove problematic device from cache
bluetoothctl remove <MAC_ADDRESS>

# Restart scanning
bluetoothctl scan off
bluetoothctl scan on
```

**Step 3: Manual Pairing Workflow**
```bash
# Put device in pairing mode first, then:
bluetoothctl pair <MAC_ADDRESS>
bluetoothctl trust <MAC_ADDRESS>
bluetoothctl connect <MAC_ADDRESS>
```

**Step 4: Alternative Approaches**
```bash
# Trust-first approach (for some devices)
bluetoothctl trust <MAC_ADDRESS>
bluetoothctl connect <MAC_ADDRESS>

# Direct connection (audio devices sometimes work)
bluetoothctl connect <MAC_ADDRESS>
```

### Audio Device Integration

**PipeWire Bluetooth Issues:**
- Profile availability errors: `br-connection-profile-unavailable`
- Service discovery works but connection fails
- Devices show correct UUIDs but won't maintain connection

**Troubleshooting Audio Devices:**
```bash
# Verify PipeWire Bluetooth support
systemctl --user status pipewire-pulse

# Check for audio-related errors
journalctl -u bluetooth.service --since "1 hour ago"

# For persistent issues, restart audio subsystem
systemctl --user restart pipewire-pulse
```

**Device-Specific Notes:**
- **Sony devices (WF-C710N, etc.)**: Often require specific timing - put in pairing mode, remove from cache, then pair immediately
- **Keyboards (HHKB, etc.)**: Usually have simpler pairing - hold Fn + Bluetooth key combination
- **Audio timing**: Some devices exit pairing mode quickly - work fast through the sequence

## System Update Troubleshooting

### Common Package Conflicts

When encountering package conflicts during system updates:

1. **Package Replacements**
   ```bash
   # Common replacements (answer Y when prompted)
   sdl2 → sdl2-compat
   webrtc-audio-processing → webrtc-audio-processing-0.3
   ```

2. **QEMU Architecture Removal**
   ```bash
   # If qemu-system-cris conflicts with qemu-common
   sudo pacman -Rdd qemu-system-cris
   sudo pacman -R qemu-emulators-full qemu-full
   sudo pacman -Syu
   sudo pacman -S qemu-full
   ```

3. **Held Back Packages**
   ```bash
   # If packages don't update during system upgrade
   sudo pacman -S specific-package-name
   ```

## Development Environment Setup

### Essential Development Tools

```bash
# Base development
sudo pacman -S base-devel git

# Editors
sudo pacman -S helix neovim

# Shell and terminal
sudo pacman -S zsh tmux alacritty

# Language-specific
sudo pacman -S go rust python nodejs npm

# Tools from this repository's requirements
sudo pacman -S fzf ripgrep fd bat eza
yay -S uv  # Python package manager (from AUR)
```

### System Paths and Environment

Arch Linux specific paths:
- System binaries: `/usr/bin`
- User binaries: `~/.local/bin`
- System config: `/etc`
- User config: `~/.config`
- Systemd services: `/usr/lib/systemd/system/`

## Security Considerations

### Keyring Management

```bash
# Update keyring if signature errors occur
sudo pacman -Sy archlinux-keyring
sudo pacman-key --refresh-keys
```

### Service Hardening

- Always use systemctl for service management
- Check service status after updates
- Review `/etc` configuration files after major updates

## Arch-Specific Makefile Targets

When using the dotfiles Makefile on Arch:

```bash
# Install Arch-specific configurations
make -C make -f arch.mk install  # If implemented

# Check Arch dependencies
make check-dependency  # Will verify pacman packages
```

## Common Issues and Solutions

### 1. Bluetooth Not Working After Update
```bash
# Reload modules
sudo modprobe -r btusb
sudo modprobe btusb

# Check kernel modules
lsmod | grep bluetooth
```

### 2. Package Signature Errors
```bash
# Refresh keys
sudo pacman-key --refresh-keys
sudo pacman -Sy archlinux-keyring
```

### 3. Partial Update Issues
```bash
# Never do partial updates
# Always use -Syu, not just -S
sudo pacman -Syu
```

## References

- [Arch Wiki - Bluetooth](https://wiki.archlinux.org/title/Bluetooth)
- [Arch Wiki - Pacman](https://wiki.archlinux.org/title/Pacman)
- [Arch Wiki - General Recommendations](https://wiki.archlinux.org/title/General_recommendations)