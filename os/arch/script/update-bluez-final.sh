#!/bin/bash

echo "Updating remaining bluez packages..."
echo

# Update bluez packages specifically
sudo pacman -S bluez bluez-libs bluez-utils --noconfirm

echo
echo "Final bluetooth package versions:"
pacman -Q bluez bluez-libs bluez-utils bluez-obex 2>/dev/null | column -t

echo
echo "Restarting bluetooth service..."
sudo systemctl restart bluetooth

echo
echo "Bluetooth service status:"
systemctl status bluetooth --no-pager | head -n 5