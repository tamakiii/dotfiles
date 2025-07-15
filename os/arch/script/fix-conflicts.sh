#!/bin/bash
set -euo pipefail

echo "Fixing package conflicts before system update..."
echo

# Remove conflicting qemu-system-cris
echo "1. Removing qemu-system-cris (conflicts with qemu-common 10.0.2)..."
sudo pacman -R qemu-system-cris --noconfirm

echo
echo "2. Now running system update with conflict resolutions..."
echo "   - Will replace sdl2 with sdl2-compat"
echo "   - Will replace webrtc-audio-processing with webrtc-audio-processing-0.3"
echo

# Run update with automatic conflict resolution
sudo pacman -Syu --noconfirm

echo
echo "Update complete! Checking bluez version..."
pacman -Q bluez bluez-libs bluez-utils 2>/dev/null | column -t