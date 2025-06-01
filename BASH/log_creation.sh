#!/bin/bash

#############################################################
# Description: Script Will Help To Generate Sample Logs
# Version: 1.0.0
# Created Date :- 01/06/2025
# Last Modified Date: XX/XX/XXXX
# Author: Rishikesh Gulhane
#############################################################

# Configs
LOG_DIR="/tmp/log/sample_log"
LOG_FILE="$LOG_DIR/sample.log"
INTERVAL=2 # seconds between log entries

# Create dir if not exist
mkdir -p "$LOG_DIR"

echo "Starting log generation. Writing to $LOG_FILE"
echo "Press Ctrl+C to stop."

# Simulated log messages
MESSAGES=(
    "INFO: User login successful."
    "WARNING: Disk space running low."
    "ERROR: Failed to connect to database."
    "DEBUG: Retrying request..."
    "INFO: Scheduled job completed."
    "ERROR: Null pointer exception in module X."
    "INFO: API responded with status 200."
    "WARNING: CPU usage is over 80%."
)

# Infinite loop to simulate logs
while true; do
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}
    echo "[$TIMESTAMP] $MESSAGE" >> "$LOG_FILE"
    sleep "$INTERVAL"
done

