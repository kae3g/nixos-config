#!/usr/bin/env bash

# Toggle script for hyprsunset
# Checks if blue light filter is active and toggles it

# Check if hyprsunset is running
if ! pgrep -x "hyprsunset" > /dev/null; then
    echo "hyprsunset is not running. Starting it first..."
    hyprsunset &
    sleep 1
fi

# Create a state file to track current state
STATE_FILE="$HOME/.cache/hyprsunset_state"

# Create cache directory if it doesn't exist
mkdir -p "$(dirname "$STATE_FILE")"

# Check current state (default to "off" if file doesn't exist)
if [[ -f "$STATE_FILE" ]]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="off"
fi

# Toggle the state
if [[ "$CURRENT_STATE" == "off" ]]; then
    # Enable blue light filter (lower temperature = warmer)
    hyprctl hyprsunset temperature 3000
    echo "on" > "$STATE_FILE"
    echo "Blue light filter enabled"
else
    # Disable blue light filter (return to normal)
    hyprctl hyprsunset identity
    echo "off" > "$STATE_FILE"
    echo "Blue light filter disabled"
fi
