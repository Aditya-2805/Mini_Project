#!/bin/bash

# -----------------------------
# Network Interface Info Logger
# -----------------------------

# Log file location
LOG_FILE="$HOME/network_interface_log.csv"

# Create log file with headers if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Interface,IP Address,MAC Address,Link Status" > "$LOG_FILE"
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

# Get all network interfaces except loopback
INTERFACES=$(ls /sys/class/net | grep -v lo)

# Loop through each interface and gather info
for IFACE in $INTERFACES; do
    # Get IP address
    IP=$(ip -4 addr show "$IFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    
    # Get MAC address
    MAC=$(cat /sys/class/net/$IFACE/address)
    
    # Get link status (up/down)
    STATUS=$(cat /sys/class/net/$IFACE/operstate)
    
    # Print to terminal
    echo "Interface: $IFACE"
    echo "IP Address: ${IP:-N/A}"
    echo "MAC Address: $MAC"
    echo "Link Status: $STATUS"
    echo "-------------------------"
    
    # Append to CSV log
    echo "$DATE,$TIME,$IFACE,${IP:-N/A},$MAC,$STATUS" >> "$LOG_FILE"
done

echo "Network interface information logged to $LOG_FILE"
