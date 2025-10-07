#!/bin/bash

# Folder with wallpapers
WALLFOLDER="/home/vai/Pictures/Loop"

# File to store current index
INDEXFILE="/tmp/hyprwall_index"

# Get total wallpapers
TOTAL=$(ls "$WALLFOLDER"/*.{jpg,png,webp} 2>/dev/null | wc -l)
echo "Total wallpapers: $TOTAL"

# Read current index or start at 0
if [[ -f $INDEXFILE ]]; then
    INDEX=$(cat $INDEXFILE)
else
    INDEX=0
fi
echo "Current index: $INDEX"
# Compute next index
INDEX=$(( (INDEX + 1) % TOTAL ))

# Save index for next time
echo $INDEX > $INDEXFILE

# Get the next wallpaper
WALL=$(ls "$WALLFOLDER"/*.{jpg,png,webp} 2>/dev/null | sed -n "$((INDEX + 1))p")
echo "Next wallpaper: $WALL"
# Set wallpaper on all monitors
hyprctl hyprpaper wallpaper "HDMI-A-1,$WALL"

