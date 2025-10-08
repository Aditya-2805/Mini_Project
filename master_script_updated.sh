#!/bin/bash

# ----------------------------------------
# Main Network Analytics Suite (Optimized)
# ----------------------------------------

# Directory where all scripts are stored
SCRIPT_DIR="$HOME/Documents/OST mini proj"

# Combined master log
MASTER_LOG="$HOME/network_analytics_master_log.csv"

# Create master log with headers if not exists
if [ ! -f "$MASTER_LOG" ]; then
    echo "Date,Time,Module,Details" > "$MASTER_LOG"
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

echo "========================================"
echo "  Network Analytics Suite"
echo "  Date: $DATE  Time: $TIME"
echo "========================================"

# Declare scripts and their labels
declare -A SCRIPTS=(
    ["Network Speed Test"]="$SCRIPT_DIR/network_speed_test.sh"
    ["Network Interface Info"]="$SCRIPT_DIR/network_interface.sh"
    ["DNS Resolver Check"]="$SCRIPT_DIR/dns_resolver_check.sh"
    ["WiFi Signal Monitor"]="$SCRIPT_DIR/signal_strength.sh"
    ["HTTP Availability Check"]="$SCRIPT_DIR/http_availibility_checker.sh"
)

# Loop through each script
for MODULE in "${!SCRIPTS[@]}"; do
    SCRIPT_PATH="${SCRIPTS[$MODULE]}"
    echo -e "\n>>> Running: $MODULE"

    if [ -f "$SCRIPT_PATH" ]; then
        OUTPUT=$("$SCRIPT_PATH" 2>&1)
        CLEAN_OUTPUT=$(echo "$OUTPUT" | tr '\n' ' ' | tr -s ' ')
        echo "$DATE,$TIME,$MODULE,\"$CLEAN_OUTPUT\"" >> "$MASTER_LOG"
    else
        echo "⚠️  Script not found: $SCRIPT_PATH"
        echo "$DATE,$TIME,$MODULE,Script not found" >> "$MASTER_LOG"
    fi
done

echo -e "\n✅ Network analytics completed."
echo "📄 Master log saved at: $MASTER_LOG"
echo "========================================"
