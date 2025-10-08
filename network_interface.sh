#!/bin/bash

# ----------------------------------------
# Enhanced Network Interface Info Logger
# ----------------------------------------

# Log file
LOG_FILE="$HOME/network_interface_log.csv"

# Check dependencies
if ! command -v ip &>/dev/null; then
    echo "Error: 'ip' command not found. Please install iproute2."
    exit 1
fi

if [ ! -d /sys/class/net ]; then
    echo "Error: /sys/class/net directory not found. System may not expose network interfaces this way."
    exit 1
fi

# Create log file with headers if not exists or empty
if [ ! -s "$LOG_FILE" ]; then
    echo "Date,Time,Interface,IP Address,MAC Address,Link Status,Speed(Mbps),MTU,RX Packets,TX Packets" > "$LOG_FILE"
fi

# Default interval (seconds)
INTERVAL=${1:-10}

echo "Starting continuous network logging every $INTERVAL seconds..."
echo "Logs saved to: $LOG_FILE"
echo "Press Ctrl+C to stop."
echo "----------------------------------------"

while true; do
    DATE=$(date '+%Y-%m-%d')
    TIME=$(date '+%H:%M:%S')
    INTERFACES=$(ls /sys/class/net | grep -v lo)

    for IFACE in $INTERFACES; do
        # IP address
        IP=$(ip -4 addr show "$IFACE" | awk '/inet / {print $2}' | cut -d'/' -f1)

        # MAC address
        if [ -r "/sys/class/net/$IFACE/address" ]; then
            MAC=$(cat /sys/class/net/$IFACE/address)
        else
            MAC="N/A"
        fi

        # Link status
        STATUS=$(cat /sys/class/net/$IFACE/operstate 2>/dev/null || echo "unknown")

        # Interface speed
        SPEED=$(cat /sys/class/net/$IFACE/speed 2>/dev/null || echo "N/A")

        # MTU (Maximum Transmission Unit)
        MTU=$(ip link show "$IFACE" | awk '/mtu/ {print $5}')

        # RX/TX packets
        RX=$(cat /sys/class/net/$IFACE/statistics/rx_packets 2>/dev/null || echo "0")
        TX=$(cat /sys/class/net/$IFACE/statistics/tx_packets 2>/dev/null || echo "0")

        # Print to terminal
        echo "[$TIME] Interface: $IFACE | IP: ${IP:-N/A} | MAC: $MAC | Status: $STATUS | Speed: ${SPEED}Mbps | MTU: $MTU | RX: $RX | TX: $TX"

        # Append to CSV log
        echo "\"$DATE\",\"$TIME\",\"$IFACE\",\"${IP:-N/A}\",\"$MAC\",\"$STATUS\",\"$SPEED\",\"$MTU\",\"$RX\",\"$TX\"" >> "$LOG_FILE"
    done

    echo "----------------------------------------"
    sleep "$INTERVAL"
done
