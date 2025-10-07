#!/bin/bash

# ----------------------------------------
# Wi-Fi Signal Strength Monitor
# ----------------------------------------

# Log file
LOG_FILE="$HOME/wifi_signal_log.csv"

# Wi-Fi interface name (auto-detect first wireless interface)
INTERFACE=$(iwconfig 2>/dev/null | grep -o '^[a-zA-Z0-9]*' | head -1)

if [ -z "$INTERFACE" ]; then
    echo "No wireless interface found. Please check your Wi-Fi connection."
    exit 1
fi

# Create log file with headers if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Interface,SSID,Signal_Level(dBm),Link_Quality" > "$LOG_FILE"
fi

# Get current time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

# Extract Wi-Fi details
INFO=$(iwconfig $INTERFACE 2>/dev/null)

SSID=$(echo "$INFO" | grep -o 'ESSID:"[^"]*"' | cut -d':' -f2 | tr -d '"')
SIGNAL=$(echo "$INFO" | grep -o 'Signal level=-[0-9]* dBm' | cut -d'=' -f2 | cut -d' ' -f1)
QUALITY=$(echo "$INFO" | grep -o 'Link Quality=[0-9]*/[0-9]*' | cut -d'=' -f2)

# Check if data is valid
if [ -z "$SIGNAL" ]; then
    echo "Could not read Wi-Fi signal strength. Are you connected to Wi-Fi?"
    exit 1
fi

# Log the result
echo "$DATE,$TIME,$INTERFACE,$SSID,$SIGNAL,$QUALITY" >> "$LOG_FILE"

# Display the output
echo "----------------------------------------"
echo "Wi-Fi Signal Strength Monitor"
echo "Date: $DATE Time: $TIME"
echo "Interface: $INTERFACE"
echo "SSID: $SSID"
echo "Signal Level: $SIGNAL dBm"
echo "Link Quality: $QUALITY"
echo "Results logged in $LOG_FILE"
echo "----------------------------------------"
