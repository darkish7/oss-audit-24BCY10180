#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Author: KRISH BISEN | Roll: 24BCY10180
# Course: Open Source Software | VITyarthi
# Description: Displays a welcome screen with system info and
#              confirms the OS license covering the environment.
# =============================================================

# --- Student & Software Variables ---
STUDENT_NAME="KRISH BISEN"         # Replace with your name
ROLL_NUMBER="24BCY10180"   # Replace with your roll number
SOFTWARE_CHOICE="Git"              # Chosen open-source software

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                          # Linux kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')       # Formatted current date
CURRENT_TIME=$(date '+%H:%M:%S')           # Current time

# --- Display the System Identity Report ---
echo "============================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT         "
echo "============================================================"
echo ""
echo "  Student    : $STUDENT_NAME ($ROLL_NUMBER)"
echo "  Software   : $SOFTWARE_CHOICE"
echo "------------------------------------------------------------"
echo "  Distro     : $DISTRO"
echo "  Kernel     : $KERNEL"
echo "  User       : $USER_NAME"
echo "  Home Dir   : $HOME_DIR"
echo "  Uptime     : $UPTIME"
echo "  Date       : $CURRENT_DATE"
echo "  Time       : $CURRENT_TIME"
echo "------------------------------------------------------------"

# --- License message for the OS (Linux is GPL v2) ---
echo "  OS License : The Linux kernel is licensed under the"
echo "               GNU General Public License version 2 (GPL v2)."
echo "               This means you have the freedom to run, study,"
echo "               modify, and distribute this software."
echo ""
echo "  Git License: Git itself is also licensed under GPL v2 —"
echo "               the same license Linus Torvalds chose when"
echo "               he could no longer use BitKeeper in 2005."
echo "============================================================"
echo ""
