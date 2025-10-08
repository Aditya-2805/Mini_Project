#!/bin/bash

# -----------------------------
# Main Network Analytics Suite
# -----------------------------

# Directory where individual scripts are located
SCRIPT_DIR="$HOME/network_scripts"

# Combined log file
MASTER_LOG="$HOME/network_analytics_master_log.csv"

# Create master log with headers if not exists
if [ ! -f "$MASTER_LOG" ]; then
    echo "Date,Time,Module,Details" > "$MASTER_LOG"
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

echo "Starting network analytics suite..."
echo "Date: $DATE Time: $TIME"
echo "-------------------------"

# 1. Run Network Speed Tester
if [ -f "/home/anonymous/Documents/OST mini proj/network_speed_test.sh" ]; then
    echo "Running Network Speed Test..."
    SPEED_OUTPUT=$("/home/anonymous/Documents/OST mini proj/network_speed_test.sh")
    echo "$DATE,$TIME,Network Speed Test,\"$(echo "$SPEED_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "Network speed script not found!"
fi

# 2. Run Network Interface Info
if [ -f "/home/anonymous/Documents/OST mini proj/network_interface.sh" ]; then
    echo "Running Network Interface Info..."
    IFACE_OUTPUT=$("/home/anonymous/Documents/OST mini proj/network_interface.sh")
    echo "$DATE,$TIME,Network Interface Info,\"$(echo "$IFACE_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "Network interface script not found!"
fi

# 3. Run DNS Resolver Check
if [ -f "/home/anonymous/Documents/OST mini proj/dns_resolver_check.sh" ]; then
    echo "Running DNS Resolver Check..."
    DNS_OUTPUT=$("/home/anonymous/Documents/OST mini proj/dns_resolver_check.sh")
    echo "$DATE,$TIME,DNS Resolver Check,\"$(echo "$DNS_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "DNS resolver script not found!"
fi

# 4. Run Wi-Fi Signal Monitor
if [ -f "/home/anonymous/Documents/OST mini proj/signal_strength.sh" ]; then
    echo "Running Wi-Fi Signal Monitor..."
    WIFI_OUTPUT=$("/home/anonymous/Documents/OST mini proj/signal_strength.sh")
    echo "$DATE,$TIME,WiFi Signal Monitor,\"$(echo "$WIFI_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "Wi-Fi signal monitor script not found!"
fi

# 5. Run HTTP Availability Check
if [ -f "/home/anonymous/Documents/OST mini proj/http_availibility_checker.sh" ]; then
    echo "Running HTTP Availability Check..."
    HTTP_OUTPUT=$("/home/anonymous/Documents/OST mini proj/http_availibility_checker.sh")
    echo "$DATE,$TIME,HTTP Availability Check,\"$(echo "$HTTP_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "HTTP availability checker script not found!"
fi

echo "-------------------------"
echo "Network analytics completed."
echo "Master log saved at $MASTER_LOG"
