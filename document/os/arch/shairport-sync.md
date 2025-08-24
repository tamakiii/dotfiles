# Shairport Sync on Arch Linux

This document covers setting up Shairport Sync to receive AirPlay audio streams from Apple devices (iPhone, iPad, Mac) on Arch Linux with PipeWire.

## Overview

Shairport Sync is an AirPlay audio player that allows your Linux machine to act as an AirPlay receiver, enabling streaming from Apple devices running Apple Music, Spotify, and other audio sources.

## Installation

```bash
# Install from official repositories
sudo pacman -S shairport-sync avahi

# Enable avahi for device discovery
sudo systemctl enable --now avahi-daemon.service
```

## Configuration Issues with PipeWire

### Problem
The default system service configuration doesn't work well with PipeWire because:
1. System services can't access user PipeWire sessions
2. PipeWire backend (`pw`) has timing information issues
3. PulseAudio backend (`pa`) can't connect to user PulseAudio/PipeWire session

### Solution: User Service

The best approach is to run Shairport Sync as a user service:

```bash
# Create user systemd directory
mkdir -p ~/.config/systemd/user

# Create user-specific config
cp /etc/shairport-sync.conf ~/.config/shairport-sync.conf

# Create user service
cat > ~/.config/systemd/user/shairport-sync.service << 'EOF'
[Unit]
Description=Shairport Sync - AirPlay Audio Receiver
After=pipewire.service
Wants=pipewire.service

[Service]
Type=simple
ExecStart=/usr/bin/shairport-sync -c %h/.config/shairport-sync.conf
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF

# Enable and start user service
systemctl --user daemon-reload
systemctl --user enable --now shairport-sync.service

# Enable lingering for auto-start on boot
sudo loginctl enable-linger $(whoami)
```

## Configuration

The configuration file supports multiple backends:

```bash
# Check available backends
shairport-sync -h | grep -A 10 "Available audio backends"
```

Common backends on Arch Linux:
- `alsa` (default) - ALSA backend
- `pw` - PipeWire backend (may have timing issues)
- `pa` - PulseAudio backend (works with PipeWire's PA compatibility)

### Recommended Configuration

Edit `~/.config/shairport-sync.conf`:

```conf
// Use PulseAudio backend for PipeWire compatibility
output_backend = "pa";
```

## Troubleshooting

### Check Service Status
```bash
systemctl --user status shairport-sync.service
journalctl --user -u shairport-sync.service -f
```

### Test Manual Execution
```bash
# Test if shairport-sync works manually
shairport-sync -c ~/.config/shairport-sync.conf -v
```

### Check Audio System
```bash
# Verify PipeWire is running
systemctl --user status pipewire

# Check available audio sinks
pactl list sinks short

# Monitor audio streams while testing
pactl list sink-inputs
```

### Common Error Messages

1. **"PipeWire backend can not get timing information"**
   - Switch to PulseAudio backend (`output_backend = "pa"`)

2. **"failed to connect to the pulseaudio context"**
   - Use user service instead of system service

3. **"Invalid audio backend selected"**
   - Check available backends with `shairport-sync -h`

## Usage

After setup:

1. **On iPhone/iPad**: Open Control Center → tap AirPlay button → select "retriever" (your hostname)
2. **On Mac**: Click AirPlay icon in music app → select "retriever"

## Device Discovery

Your Arch Linux machine will appear as your hostname (e.g., "retriever") in the AirPlay device list. To change this, edit the config file:

```conf
// Uncomment and modify
name = "My Linux AirPlay";
```

## Persistence

The user service with lingering enabled will:
- Start automatically on login
- Restart on failure
- Survive system reboots (with lingering enabled)

## Network Requirements

- Both devices must be on the same network
- Avahi daemon must be running for mDNS discovery
- Firewall may need to allow AirPlay ports (5000/7000, UDP 6001-6011)

## Audio Quality

Shairport Sync supports:
- Apple Lossless (ALAC) audio
- AirPlay 2 with multi-room synchronization
- Various sample rates and bit depths depending on backend