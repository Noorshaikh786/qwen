#!/bin/bash

# Script to open YouTube 2K video tabs in the user's default browser

# Ask user for number of tabs
read -p "How many tabs do you want to open? " num_tabs

# Validate input is a positive integer
if ! [[ "$num_tabs" =~ ^[0-9]+$ ]] || [ "$num_tabs" -le 0 ]; then
    echo "Please enter a valid positive number."
    exit 1
fi

# YouTube 2K video URL (using a popular 2K video)
# This is a sample 2K video - you can replace with any 2K video URL
VIDEO_URL="https://www.youtube.com/watch?v=VPVhD8v7G5E"

# Detect the default browser and open tabs accordingly
detect_and_open() {
    local count=$1
    local url=$2
    
    # Try to detect default browser based on OS
    if command -v xdg-open &> /dev/null; then
        # Linux with xdg-open
        for ((i=1; i<=count; i++)); do
            xdg-open "$url" &
            echo "Opened tab $i"
            sleep 0.5
        done
    elif command -v open &> /dev/null; then
        # macOS
        for ((i=1; i<=count; i++)); do
            open "$url" &
            echo "Opened tab $i"
            sleep 0.5
        done
    elif command -v start &> /dev/null; then
        # Windows (via WSL or Git Bash)
        for ((i=1; i<=count; i++)); do
            start "" "$url" &
            echo "Opened tab $i"
            sleep 0.5
        done
    else
        echo "Could not detect browser. Please run this script on your native OS."
        exit 1
    fi
}

echo "Opening $num_tabs tab(s) with a 2K YouTube video..."
detect_and_open "$num_tabs" "$VIDEO_URL"
echo "Done! Check your browser."
