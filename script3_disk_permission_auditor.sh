#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Author: KRISH BISEN | Roll: 24BCY10180
# Course: Open Source Software | VITyarthi
# Description: Loops through key system directories and reports
#              permissions, owner, and disk usage for each.
#              Also checks Git's config directory specifically.
# =============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/doc/git")

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR — SYSTEM REPORT       "
echo "============================================================"
printf "%-25s %-20s %-10s\n" "Directory" "Permissions/Owner" "Size"
echo "------------------------------------------------------------"

# --- For loop: iterate over each directory in the list ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions and owner using ls and awk
        # ls -ld gives: permissions links owner group size date name
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')   # e.g. drwxr-xr-x
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')   # e.g. root
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')   # e.g. root

        # Get disk usage with du; 2>/dev/null suppresses permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "%-25s %-20s %-10s\n" "$DIR" "$PERMS ($OWNER:$GROUP)" "$SIZE"
    else
        # Directory doesn't exist on this system
        printf "%-25s %-20s\n" "$DIR" "[Does not exist]"
    fi
done

echo "------------------------------------------------------------"
echo ""

# --- Check Git's specific config file and directory ---
echo "  --- Git-Specific Configuration Audit ---"
echo ""

# Git's global config file lives at ~/.gitconfig for each user
GIT_GLOBAL_CONFIG="$HOME/.gitconfig"
if [ -f "$GIT_GLOBAL_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $1, $3, $4}')
    echo "  [✔] Git global config found: $GIT_GLOBAL_CONFIG"
    echo "      Permissions : $PERMS"
    echo "      Contents    :"
    # Display config content with indentation
    cat "$GIT_GLOBAL_CONFIG" | sed 's/^/      /'
else
    echo "  [!] No global Git config found at $GIT_GLOBAL_CONFIG"
    echo "      Run 'git config --global user.name \"Your Name\"' to create it."
fi

echo ""

# Git's system-wide config (usually at /etc/gitconfig)
GIT_SYSTEM_CONFIG="/etc/gitconfig"
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $1, $3, $4}')
    echo "  [✔] Git system config found: $GIT_SYSTEM_CONFIG"
    echo "      Permissions : $PERMS"
else
    echo "  [!] No system-wide Git config at $GIT_SYSTEM_CONFIG"
fi

echo ""
echo "============================================================"
