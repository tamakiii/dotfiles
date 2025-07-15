#!/bin/bash

echo "Updating Bluetooth packages on Arch Linux..."
echo

# Update system and bluetooth packages
echo "1. Updating bluez packages..."
sudo pacman -Syu bluez bluez-libs bluez-utils --needed --noconfirm

# Install additional packages
echo
echo "2. Installing bluez-obex for file transfer support..."
sudo pacman -S bluez-obex --needed --noconfirm

echo
echo "3. Installing pipewire-bluetooth for audio support..."
sudo pacman -S pipewire-bluetooth --needed --noconfirm

# Restart bluetooth service
echo
echo "4. Restarting bluetooth service..."
sudo systemctl daemon-reload
sudo systemctl restart bluetooth

# Check status
echo
echo "5. Checking bluetooth service status..."
systemctl status bluetooth --no-pager

echo
echo "Bluetooth update complete!"
echo
echo "Current package versions:"
pacman -Q bluez bluez-libs bluez-utils bluez-obex pipewire-bluetooth 2>/dev/null | column -t