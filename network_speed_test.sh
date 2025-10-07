#!/bin/bash

# -----------------------------
# Simple Network Speed Tester
# -----------------------------

# Log file location
LOG_FILE="$HOME/network_speed_log.csv"

# Ping test (average ping to 8.8.8.8)
PING=$(ping -c 4 8.8.8.8 | tail -1 | awk -F '/' '{print $5}')

# Download test (1 MB file from tele2.net)
URL="http://speedtest.tele2.net/1MB.zip"
DOWNLOAD_TIME=$(curl -o /dev/null -s -w %{time_total} $URL)

# Calculate download speed in Mbps
# 1 MB = 8 Megabits, so speed = 8 / time seconds
DOWNLOAD_SPEED=$(echo "scale=2; 8/($DOWNLOAD_TIME)" | bc)

# Upload speed (set 0, as no server for upload test)
UPLOAD_SPEED=0

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

# Create log file with headers if not exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Download(Mbps),Upload(Mbps),Ping(ms)" > "$LOG_FILE"
fi

# Log results
echo "$DATE,$TIME,$DOWNLOAD_SPEED,$UPLOAD_SPEED,$PING" >> "$LOG_FILE"

# Display results
echo "----------------------------"
echo "Network Speed Test Completed"
echo "Date: $DATE Time: $TIME"
echo "Download Speed: $DOWNLOAD_SPEED Mbps"
echo "Upload Speed: $UPLOAD_SPEED Mbps (Not measured)"
echo "Ping: $PING ms"
echo "Results logged in $LOG_FILE"
echo "----------------------------"
