#!/usr/bin/env python3

import json
import subprocess
import sys

def get_player_status():
    """Get current media player status using playerctl"""
    try:
        # Get player status
        status = subprocess.check_output(
            ["playerctl", "status"],
            stderr=subprocess.DEVNULL
        ).decode("utf-8").strip()

        # Get metadata
        artist = subprocess.check_output(
            ["playerctl", "metadata", "artist"],
            stderr=subprocess.DEVNULL
        ).decode("utf-8").strip()

        title = subprocess.check_output(
            ["playerctl", "metadata", "title"],
            stderr=subprocess.DEVNULL
        ).decode("utf-8").strip()

        # Format output
        if status == "Playing":
            icon = ""
        elif status == "Paused":
            icon = ""
        else:
            icon = ""

        # Combine artist and title
        if artist and title:
            text = f"{artist} - {title}"
        elif title:
            text = title
        else:
            text = "No media"

        # Truncate if too long
        max_length = 35
        if len(text) > max_length:
            text = text[:max_length - 3] + "..."

        output = {
            "text": f"{icon} {text}",
            "tooltip": f"{artist}\n{title}\nStatus: {status}",
            "class": status.lower()
        }

        print(json.dumps(output))

    except subprocess.CalledProcessError:
        # No player found or no media playing
        output = {
            "text": "",
            "tooltip": "No media playing",
            "class": "stopped"
        }
        print(json.dumps(output))
    except Exception as e:
        output = {
            "text": "",
            "tooltip": f"Error: {str(e)}",
            "class": "error"
        }
        print(json.dumps(output))

if __name__ == "__main__":
    get_player_status()
