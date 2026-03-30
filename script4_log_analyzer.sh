#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Author: KRISH BISEN | Roll: 24BCY10180
# Course: Open Source Software | VITyarthi
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, and prints matching lines summary.
#              Accepts log file path and keyword as arguments.
# Usage: ./script4_log_analyzer.sh /var/log/syslog error
#        ./script4_log_analyzer.sh /var/log/auth.log warning
# =============================================================

# --- Accept command-line arguments ---
LOGFILE=$1                   # First argument: path to log file
KEYWORD=${2:-"error"}        # Second argument: keyword (default: "error")

# --- Counter variable to track keyword matches ---
COUNT=0

echo "============================================================"
echo "              LOG FILE ANALYZER — FOSS AUDIT               "
echo "============================================================"

# --- Validate: check if user provided a log file path ---
if [ -z "$LOGFILE" ]; then
    echo "  [!] No log file specified."
    echo "      Usage: $0 /path/to/logfile [keyword]"
    echo ""
    echo "  Tip: Try these common Linux log files:"
    echo "       /var/log/syslog        (general system log)"
    echo "       /var/log/auth.log      (authentication events)"
    echo "       /var/log/kern.log      (kernel messages)"
    exit 1
fi

# --- Validate: check if the file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [✘] Error: File '$LOGFILE' not found."

    # --- Retry logic: suggest alternative log files if file missing ---
    echo ""
    echo "  Searching for available log files on this system..."
    RETRY=0
    # do-while style: loop runs at least once, continues if logs not found
    while true; do
        RETRY=$((RETRY + 1))
        # Check a list of common log file locations
        for ALT_LOG in /var/log/syslog /var/log/messages /var/log/kern.log /var/log/auth.log; do
            if [ -f "$ALT_LOG" ]; then
                echo "  [✔] Found: $ALT_LOG — try running:"
                echo "      $0 $ALT_LOG $KEYWORD"
            fi
        done
        # Exit retry loop after one pass (simulates do-while behaviour)
        if [ $RETRY -ge 1 ]; then
            break
        fi
    done
    exit 1
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  [!] Warning: '$LOGFILE' exists but is empty. Nothing to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------"

# --- While-read loop: read file line by line ---
while IFS= read -r LINE; do
    # if-then: check if current line contains the keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter for each match
    fi
done < "$LOGFILE"   # Redirect file into the while loop

echo ""
echo "  Total lines matched : $COUNT"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"
echo ""

# --- Show last 5 matching lines for context ---
if [ $COUNT -gt 0 ]; then
    echo "  --- Last 5 Lines Containing '$KEYWORD' ---"
    # Use grep to filter matches, then tail to get last 5
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        echo "  > $MATCH_LINE"
    done
else
    echo "  No lines containing '$KEYWORD' were found in this log."
fi

echo ""
echo "============================================================"
