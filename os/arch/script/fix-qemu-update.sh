#!/bin/bash

echo "Fixing QEMU conflicts and updating system..."
echo

# Remove the problematic qemu packages that depend on qemu-system-cris
echo "1. Removing qemu-emulators-full and qemu-full (they depend on obsolete qemu-system-cris)..."
sudo pacman -R qemu-emulators-full qemu-full --noconfirm

echo
echo "2. Now running system update..."
# Run update answering Yes to replacements
echo -e "Y\nY\n" | sudo pacman -Syu

echo
echo "3. Reinstalling QEMU packages with new structure..."
sudo pacman -S qemu-full --noconfirm

echo
echo "Update complete! Checking versions..."
echo "Bluez packages:"
pacman -Q bluez bluez-libs bluez-utils bluez-obex 2>/dev/null | column -t
echo
echo "QEMU version:"
pacman -Q qemu-common qemu-full 2>/dev/null | column -t