#!/bin/bash
set -euo pipefail

echo "Removing qemu-system-cris and updating system..."
echo

# Force remove qemu-system-cris
echo "1. Force removing qemu-system-cris..."
sudo pacman -Rdd qemu-system-cris --noconfirm

echo
echo "2. Now running system update..."
# Run update with automatic conflict resolution
sudo pacman -Syu --noconfirm

echo
echo "3. Reinstalling QEMU full package..."
sudo pacman -S qemu-full --noconfirm

echo
echo "Update complete! Final versions:"
echo
echo "Bluez packages:"
pacman -Q bluez bluez-libs bluez-utils bluez-obex 2>/dev/null | column -t
echo
echo "QEMU version:"
pacman -Q qemu-common 2>/dev/null | column -t