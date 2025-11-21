#!/bin/bash

# WiFi menu script for Waybar
# Shows available WiFi networks and allows connection via rofi

# Get list of available networks
networks=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | sort -t: -k2 -rn)

if [ -z "$networks" ]; then
    notify-send "WiFi" "No networks found"
    exit 1
fi

# Format for rofi menu
formatted_networks=""
while IFS=: read -r ssid signal security; do
    if [ -n "$ssid" ]; then
        # Add icon based on signal strength
        if [ "$signal" -gt 75 ]; then
            icon="󰤨"
        elif [ "$signal" -gt 50 ]; then
            icon="󰤥"
        elif [ "$signal" -gt 25 ]; then
            icon="󰤢"
        else
            icon="󰤟"
        fi

        # Add lock icon if secured
        if [ -n "$security" ]; then
            lock="  "
        else
            lock=""
        fi

        formatted_networks+="$icon $ssid ${signal}%$lock\n"
    fi
done <<< "$networks"

# Show rofi menu
chosen=$(echo -e "$formatted_networks" | rofi -dmenu -i -p "WiFi Networks" -theme-str 'window {width: 400px;}')

if [ -n "$chosen" ]; then
    # Extract SSID from chosen line
    ssid=$(echo "$chosen" | sed 's/^[^ ]* //' | sed 's/ [0-9]*%.*$//')

    # Check if network requires password
    if echo "$chosen" | grep -q ""; then
        # Prompt for password
        password=$(rofi -dmenu -password -p "Password for $ssid" -theme-str 'window {width: 400px;}')

        if [ -n "$password" ]; then
            nmcli dev wifi connect "$ssid" password "$password"
        fi
    else
        # Connect without password
        nmcli dev wifi connect "$ssid"
    fi

    # Notify result
    if [ $? -eq 0 ]; then
        notify-send "WiFi" "Connected to $ssid"
    else
        notify-send "WiFi" "Failed to connect to $ssid"
    fi
fi
