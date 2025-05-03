#!/bin/bash

# Get volume and mute status for the default sink
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

# Check if muted
if [[ $VOLUME_INFO == *"[MUTED]"* ]]; then
    MUTED=true
else
    MUTED=false
fi

# Extract volume as a float (e.g., 0.65)
VOLUME_FLOAT=$(echo $VOLUME_INFO | awk '{print $2}')

# Convert to percentage (0-100) - multiply by 100 correctly
VOLUME_PERCENT=$(awk -v vol="$VOLUME_FLOAT" 'BEGIN {printf "%.0f", vol * 100}')

# If VOLUME_PERCENT is empty or not a number, set default
# if [[ -z "$VOLUME_PERCENT" || ! "$VOLUME_PERCENT" =~ ^[0-9]+$ ]]; then
#     VOLUME_PERCENT=0
# fi

# Ensure volume doesn't exceed 100%
if [[ $VOLUME_PERCENT -gt 100 ]]; then
    VOLUME_PERCENT=100
    # Set volume to 1.0 (100%)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0
fi

FILLED=$((VOLUME_PERCENT / 10))
EMPTY=$((10 - FILLED))

if [ "$MUTED" = true ]; then
    BAR=" "
else
    BAR=" "
fi

for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

# Output JSON for Waybar
echo "{\"text\": \"$BAR\", \"tooltip\": \"Volume: ${VOLUME_PERCENT}%\", \"class\": \"custom-wireplumber\"}"
