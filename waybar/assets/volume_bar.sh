#!/bin/bash

# Get volume and mute status (wpctl combines this)
output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

# Parse volume (output is like "Volume: 0.75" or "Volume: 0.50 [MUTED]")
# Use awk for floating point multiplication and formatting to integer percentage
volume=$(echo "$output" | awk '{ printf "%.0f\n", $2 * 100 }')

# Check for MUTE tag
if echo "$output" | grep -q '\[MUTED\]'; then
  muted="yes"
else
  muted="no"
fi

# Ensure volume doesn't exceed 100%
if [[ $volume -gt 100 ]]; then
    volume=100
    # Set volume to 1.0 (100%)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0
fi

FILLED=$((volume / 10))
EMPTY=$((10 - FILLED))

if [ "$muted" = "yes" ]; then
    BAR=" "
else
    BAR=" "
fi

for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

# Output JSON for Waybar
echo "{\"text\": \"$BAR\", \"tooltip\": \"Volume: ${volume}%\", \"class\": \"custom-wireplumber\"}"
