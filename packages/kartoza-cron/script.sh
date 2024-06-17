#!/usr/bin/env bash

# Variables
FLAG_FILE="/tmp/cron_flag"
CURRENT_DATE=$(date +%Y-%m-%d)
NIXOS_DIR="/etc/nixos" # Replace with your actual path
LAST_REBUILD_FILE="/var/log/last_nixos_rebuild"

# Update NixOS configuration
update_nixos() {
    cd "$NIXOS_DIR" || {
        echo "Failed to change directory to $NIXOS_DIR"
        exit 1
    }
    echo "Pulling latest NixOS configuration..."
    git pull || {
        echo "Failed to pull latest changes"
        exit 1
    }
    echo "Building NixOS configuration..."
    nix build . || {
        echo "Nix build failed"
        exit 1
    }
    echo "Updating last rebuild timestamp..."
    date +%s >"$LAST_REBUILD_FILE"
}

# Gather system statistics and format them as a Markdown table
gather_system_stats() {
    echo "Gathering system statistics..."
    CPU_LOAD=$(awk '{u+=$1} END {print u/NR}' /proc/loadavg)
    DISK_USAGE=$(df -h --output=source,pcent | tail -n +2 | awk '{print "| " $1 " | " $2 " |"}')
    HOSTNAME=$(hostname)
    LOGGED_IN_USERS=$(who | awk '{print $1}' | sort | uniq | paste -sd "," -)
    UPTIME=$(uptime | awk -F', ' '{print $1}' | sed 's/.*up //')
    LATEST_COMMIT=$(git -C "$NIXOS_DIR" rev-parse HEAD)
    LAST_REBUILD_TIMESTAMP=$(cat "$LAST_REBUILD_FILE" 2>/dev/null || echo "0")
    LAST_REBUILD_DURATION=$(date -d@"$(($(date +%s) - $LAST_REBUILD_TIMESTAMP))" -u +'%H:%M:%S')

    SYSTEM_STATS="
| **Statistic**              | **Value**                         |
|----------------------------|-----------------------------------|
| **Host**                   | \`$HOSTNAME\`                      |
| **CPU Load (24h avg)**     | \`$CPU_LOAD\`                     |
| **Disk Usage**             |                                   |
$DISK_USAGE
| **Logged in Users**        | \`$LOGGED_IN_USERS\`              |
| **Uptime**                 | \`$UPTIME\`                       |
| **Latest Git Commit**      | \`$LATEST_COMMIT\`                |
| **Duration Since Last Rebuild** | \`$LAST_REBUILD_DURATION\` |
"
}

# Check for kill switch and take action if enabled
check_kill_switch() {
    echo "Checking kill switch..."
    KILL_SWITCH=$(skate get "$(hostname)-kill-switch")
    if [ "$KILL_SWITCH" == "enabled" ]; then
        echo "Kill switch is enabled. Initiating shutdown..."
        ntfy send "Kill switch enabled for $(hostname)."
        # Uncomment and modify the following lines based on actual kill switch behavior needed
        #zfs set keylocation=passphrase NIXROOT
        #zfs change-key -i NIXROOT
        #shutdown -h now
    fi
}

# Send a message via ntfy
ntfy_message() {
    echo "Sending notification via ntfy..."
    skate sync
    MESSAGE_CHANNEL=$(skate get "ntfy-cron")
    if [ "$MESSAGE_CHANNEL" == "Key not found" ]; then
        echo "No ntfy-message channel found. Please set one up."
        exit 1
    fi
    if [ -z "$1" ]; then
        echo "Error: At least one parameter is required."
        exit 1
    fi
    ntfy send "$MESSAGE_CHANNEL" "$(hostname): $1"
}

# Main Execution Block
if [ -f "$FLAG_FILE" ] && grep -q "$CURRENT_DATE" "$FLAG_FILE"; then
    echo "Task already executed today."
else
    echo "Starting daily maintenance task..."
    gather_system_stats
    ntfy_message "$SYSTEM_STATS"
    check_kill_switch
    update_nixos

    echo "$CURRENT_DATE" >"$FLAG_FILE"
    echo "Daily maintenance task completed."
fi
