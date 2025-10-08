#!/bin/bash

# ------------------------------------
# Enhanced DNS Resolver Check Logger
# ------------------------------------

LOG_FILE="$HOME/dns_resolver_log.csv"

# Create log file with headers if not exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Domain,DNS Server,Response Time(ms),Resolved IP,Status" > "$LOG_FILE"
fi

# Check if dig is installed
if ! command -v dig &>/dev/null; then
    echo "Error: 'dig' command not found. Please install dnsutils or bind-utils."
    exit 1
fi

# Domain to test (default: google.com)
DOMAIN=${1:-google.com}

# DNS servers to test
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "9.9.9.9")

# Optional continuous mode (set interval in seconds)
INTERVAL=0  # e.g., 60 for every minute

check_dns() {
    DATE=$(date '+%Y-%m-%d')
    TIME=$(date '+%H:%M:%S')

    echo "Checking DNS resolution for $DOMAIN..."
    echo "--------------------------------------"

    for DNS in "${DNS_SERVERS[@]}"; do
        OUTPUT=$(dig @$DNS +stats +short "$DOMAIN")
        RESPONSE=$(dig @$DNS "$DOMAIN" +stats | grep "Query time" | awk '{print $4}')
        IP=$(echo "$OUTPUT" | grep -E '^[0-9]+\.[0-9]+' | head -1)

        if [ -n "$OUTPUT" ]; then
            STATUS="Success"
        else
            STATUS="Failed"
            RESPONSE="N/A"
            IP="N/A"
        fi

        # Color output
        if [ "$STATUS" == "Success" ]; then
            COLOR="\033[0;32m"  # Green
        else
            COLOR="\033[0;31m"  # Red
        fi
        RESET="\033[0m"

        # Print result
        echo -e "DNS Server: $DNS"
        echo -e "Response Time: ${RESPONSE} ms"
        echo -e "Resolved IP: ${IP}"
        echo -e "Status: ${COLOR}${STATUS}${RESET}"
        echo "--------------------------------------"

        # Log to CSV
        echo "$DATE,$TIME,$DOMAIN,$DNS,$RESPONSE,$IP,$STATUS" >> "$LOG_FILE"
    done

    echo "Results logged to $LOG_FILE"
}

# If interval > 0, run continuously
if [ "$INTERVAL" -gt 0 ]; then
    while true; do
        check_dns
        sleep "$INTERVAL"
    done
else
    check_dns
fi
