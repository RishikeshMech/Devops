#!/bin/bash 


#############################################################
# Description: Script Will Help To Rotate And Clean Up Logs
# Version: 1.0.0
# Created Date :- 1/06/2025
# Last Modified Date: XX/XX/XXXX
# Author: Rishikesh Gulhane
############################################################


# Conf

LOG_DIR=/tmp/log/sample
BACKUP_DIR=/tmp/log/backup
DAYS_TO_KEEP=2
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
ROTATION_LOG="/tmp/log/log_rotation_activity.log"
LOG_EXTENSION="log"
#Create Backup Dir If Doesent Exist 

mkdie -p "$BACKUP_DIR"


echo "[$(date)] Starting log rotation..." >> "$ROTATION_LOG"

# Find all log files in LOG_DIR with the specified extension
find "$LOG_DIR" -type f -name "*.$LOG_EXTENSION" | while read -r LOGFILE; do
    BASENAME=$(basename "$LOGFILE")
    BACKUP_FILE="$BACKUP_DIR/${BASENAME}_${TIMESTAMP}.gz"

    # Compress and move to backup
    gzip -c "$LOGFILE" > "$BACKUP_FILE"

    # Truncate the original log file
    : > "$LOGFILE"

    echo "[$(date)] Rotated and compressed $LOGFILE to $BACKUP_FILE" >> "$ROTATION_LOG"
done

# Delete old backups
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +$DAYS_TO_KEEP -exec rm {} \; -exec echo "[$(date)] Deleted old backup: {}" >> "$ROTATION_LOG" \;

echo "[$(date)] Log rotation completed." >> "$ROTATION_LOG"
