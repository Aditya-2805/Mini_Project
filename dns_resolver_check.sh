#!/bin/bash

# -----------------------------
# DNS Resolver Check Logger
# -----------------------------

LOG_FILE="$HOME/dns_resolver_log.csv"

# Create log file with headers if not exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Domain,DNS Server,Response Time(s),Status" > "$LOG_FILE"
fi

DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

# DNS servers to check
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "9.9.9.9")

# Domain to test
DOMAIN="google.com"

echo "Checking DNS resolution for $DOMAIN..."
echo "-------------------------"

for DNS in "${DNS_SERVERS[@]}"; do
    # Use dig to query domain and measure time
    OUTPUT=$(dig @$DNS $DOMAIN +stats +short)
    
    if [ -n "$OUTPUT" ]; then
        # Successful resolution
        STATUS="Success"
        
        # Get query time from dig stats
        RESPONSE=$(dig @$DNS $DOMAIN +stats | grep "Query time" | awk '{print $4}')
    else
        STATUS="Failed"
        RESPONSE="N/A"
    fi

    # Print to terminal
    echo "DNS Server: $DNS"
    echo "Response Time: $RESPONSE ms"
    echo "Status: $STATUS"
    echo "-------------------------"

    # Append to log file
    echo "$DATE,$TIME,$DOMAIN,$DNS,$RESPONSE,$STATUS" >> "$LOG_FILE"
done

echo "DNS resolution check logged to $LOG_FILE"
