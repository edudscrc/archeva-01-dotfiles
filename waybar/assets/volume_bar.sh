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

# Debug output
echo "Raw volume info: $VOLUME_INFO" >&2
echo "Extracted float: $VOLUME_FLOAT" >&2

# Convert to percentage (0-100) - multiply by 100 correctly
VOLUME_PERCENT=$(awk -v vol="$VOLUME_FLOAT" 'BEGIN {printf "%.0f", vol * 100}')

# Debug output
echo "Calculated percentage: $VOLUME_PERCENT" >&2

# If VOLUME_PERCENT is empty or not a number, set default
if [[ -z "$VOLUME_PERCENT" || ! "$VOLUME_PERCENT" =~ ^[0-9]+$ ]]; then
    echo "Volume percent invalid, setting to 0" >&2
    VOLUME_PERCENT=0
fi

# Ensure volume doesn't exceed 100%
if [[ $VOLUME_PERCENT -gt 100 ]]; then
    VOLUME_PERCENT=100
    # Set volume to 1.0 (100%)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0
fi

# Calculate how many filled bars we need (0-10)
FILLED_BARS=$((VOLUME_PERCENT / 10))

# Make sure FILLED_BARS stays within range
if [[ $FILLED_BARS -gt 10 ]]; then
    FILLED_BARS=10
fi

# Calculate empty bars
EMPTY_BARS=$((10 - FILLED_BARS))

# Create the filled and empty bars
FILLED=""
for ((i=1; i<=FILLED_BARS; i++)); do
    FILLED="${FILLED}▮"
done

EMPTY=""
for ((i=1; i<=EMPTY_BARS; i++)); do
    EMPTY="${EMPTY}▯"
done

# Format the output
if [ "$MUTED" = true ]; then
    FORMAT=" ${FILLED}${EMPTY}"
else
    FORMAT=" ${FILLED}${EMPTY}"
fi

# Output JSON for Waybar
echo "{\"text\": \"$FORMAT\", \"tooltip\": \"Volume: ${VOLUME_PERCENT}%\", \"class\": \"custom-volume\", \"percentage\": $VOLUME_PERCENT}"