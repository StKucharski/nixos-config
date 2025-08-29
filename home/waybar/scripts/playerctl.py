#!/usr/bin/env python3

import subprocess
import json
import html

def get_metadata():
    try:
        status = subprocess.check_output(["playerctl", "status"], text=True).strip()
        title = subprocess.check_output(["playerctl", "metadata", "title"], text=True).strip()
        artist = subprocess.check_output(["playerctl", "metadata", "artist"], text=True).strip()
        return status, title, artist
    except subprocess.CalledProcessError:
        return None, None, None

status, title, artist = get_metadata()

if status is None:
    print(json.dumps({
        "text": "",
        "tooltip": "No player",
        "class": "stopped"
    }))
else:
    artist = artist.split(',')[0].split('&')[0].strip()
    safe_title = html.escape(f"{artist} - {title}")
    print(json.dumps({
        "text": safe_title,
        "tooltip": f"{status}: {artist} - {title}",
        "class": status.lower()  # "playing" or "paused"
    }))
