#!/bin/bash

# Bluetooth menu script for Waybar
# Shows paired Bluetooth devices and allows connection/disconnection via rofi

# Check if Bluetooth is powered on
bt_powered=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$bt_powered" ]; then
    choice=$(echo -e "Turn On Bluetooth" | rofi -dmenu -i -p "Bluetooth" -theme-str 'window {width: 400px;}')
    if [ "$choice" = "Turn On Bluetooth" ]; then
        bluetoothctl power on
        notify-send "Bluetooth" "Bluetooth turned on"
    fi
    exit 0
fi

# Get list of paired devices
devices=$(bluetoothctl devices | awk '{print substr($0, index($0,$3))}')

if [ -z "$devices" ]; then
    notify-send "Bluetooth" "No paired devices found"
    exit 1
fi

# Format for rofi menu
formatted_devices=""
while IFS= read -r device_name; do
    # Get device MAC address
    device_mac=$(bluetoothctl devices | grep "$device_name" | awk '{print $2}')

    # Check if device is connected
    if bluetoothctl info "$device_mac" | grep -q "Connected: yes"; then
        icon="󰂱"
        status="(Connected)"
    else
        icon="󰂲"
        status="(Disconnected)"
    fi

    formatted_devices+="$icon $device_name $status\n"
done <<< "$devices"

# Add option to turn off Bluetooth
formatted_devices+="󰂲 Turn Off Bluetooth\n"

# Show rofi menu
chosen=$(echo -e "$formatted_devices" | rofi -dmenu -i -p "Bluetooth Devices" -theme-str 'window {width: 400px;}')

if [ -n "$chosen" ]; then
    if echo "$chosen" | grep -q "Turn Off Bluetooth"; then
        bluetoothctl power off
        notify-send "Bluetooth" "Bluetooth turned off"
        exit 0
    fi

    # Extract device name
    device_name=$(echo "$chosen" | sed 's/^[^ ]* //' | sed 's/ (.*$//')

    # Get device MAC
    device_mac=$(bluetoothctl devices | grep "$device_name" | awk '{print $2}')

    # Check current connection status
    if bluetoothctl info "$device_mac" | grep -q "Connected: yes"; then
        # Disconnect
        bluetoothctl disconnect "$device_mac"
        notify-send "Bluetooth" "Disconnected from $device_name"
    else
        # Connect
        bluetoothctl connect "$device_mac"
        if [ $? -eq 0 ]; then
            notify-send "Bluetooth" "Connected to $device_name"
        else
            notify-send "Bluetooth" "Failed to connect to $device_name"
        fi
    fi
fi
