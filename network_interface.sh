#!/bin/bash

# ----------------------------------------
# Enhanced Network Interface Info Logger
# ----------------------------------------

LOG_FILE="$HOME/network_interface_log.csv"

# Check dependencies
if ! command -v ip &>/dev/null; then
    echo "Error: 'ip' command not found. Please install iproute2."
    exit 1
fi

# Optional tools for extra info
IWCONFIG_AVAILABLE=$(command -v iwconfig >/dev/null && echo 1 || echo 0)
ETHTOOL_AVAILABLE=$(command -v ethtool >/dev/null && echo 1 || echo 0)

if [ ! -d /sys/class/net ]; then
    echo "Error: /sys/class/net directory not found. System may not expose interfaces this way."
    exit 1
fi

# Create log file with headers if missing or empty
if [ ! -s "$LOG_FILE" ]; then
    echo "Date,Time,Interface,IP Address,MAC Address,Link Status,Speed(Mbps),MTU,RX Packets,TX Packets" > "$LOG_FILE"
fi

# Interval between logs (seconds)
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

        # Detect connection type & get speed
        if [ -d "/sys/class/net/$IFACE/wireless" ] && [ "$IWCONFIG_AVAILABLE" -eq 1 ]; then
            # Wi-Fi interface speed (Bit Rate)
            SPEED=$(iwconfig "$IFACE" 2>/dev/null | grep -o 'Bit Rate=[0-9.]* Mb/s' | awk -F'=' '{print $2}' | awk '{print $1}')
        else
            # Wired interface speed (via /sys or ethtool)
            SPEED=$(cat /sys/class/net/$IFACE/speed 2>/dev/null)
            if [ -z "$SPEED" ] || [ "$SPEED" = "N/A" ] && [ "$ETHTOOL_AVAILABLE" -eq 1 ]; then
                SPEED=$(ethtool "$IFACE" 2>/dev/null | awk -F': ' '/Speed:/ {print $2}' | grep -o '[0-9]\+')
            fi
        fi

        # Fallback for unknown speed
        [ -z "$SPEED" ] && SPEED="N/A"

        # MTU
        MTU=$(ip link show "$IFACE" | awk '/mtu/ {print $5}')

        # RX/TX packets
        RX=$(cat /sys/class/net/$IFACE/statistics/rx_packets 2>/dev/null || echo "0")
        TX=$(cat /sys/class/net/$IFACE/statistics/tx_packets 2>/dev/null || echo "0")

        # Print to terminal
        echo "[$TIME] Interface: $IFACE | IP: ${IP:-N/A} | MAC: $MAC | Status: $STATUS | Speed: ${SPEED} Mbps | MTU: $MTU | RX: $RX | TX: $TX"

        # Append to CSV
        echo "\"$DATE\",\"$TIME\",\"$IFACE\",\"${IP:-N/A}\",\"$MAC\",\"$STATUS\",\"$SPEED\",\"$MTU\",\"$RX\",\"$TX\"" >> "$LOG_FILE"
    done

    echo "----------------------------------------"
    sleep "$INTERVAL"
done
