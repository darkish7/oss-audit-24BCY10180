#!/bin/bash
# =============================================================
# Script 5: Open Source Manifesto Generator
# Author: KRISH BISEN | Roll: 24BCY10180
# Course: Open Source Software | VITyarthi
# Description: Interactively asks the user 3 questions, then
#              composes a personalised open-source philosophy
#              statement and saves it to a .txt file.
# =============================================================

# --- Alias concept demonstration (as a comment) ---
# In a real shell session, you might define:
#   alias today='date +%d\ %B\ %Y'
# This is how aliases work — short names for longer commands.
# In scripts, we use functions or variables instead of aliases.

# --- Welcome banner ---
echo "============================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR — VITyarthi         "
echo "============================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source philosophy statement."
echo ""
echo "------------------------------------------------------------"

# --- Read user input interactively ---
# 'read -p' displays a prompt and waits for the user to type

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs: make sure none are empty ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  [!] All three questions must be answered. Please re-run the script."
    exit 1
fi

# --- Get current date using date command ---
DATE=$(date '+%d %B %Y')

# --- Output file name: personalised using the logged-in username ---
OUTPUT="manifesto_$(whoami).txt"

echo "------------------------------------------------------------"
echo "  Generating your manifesto..."
echo ""

# --- Compose the manifesto by concatenating strings ---
# Using >> to append each line to the output file

# Clear any old version of the file first
> "$OUTPUT"

# Write the manifesto header
echo "============================================================" >> "$OUTPUT"
echo "         MY OPEN SOURCE MANIFESTO                          " >> "$OUTPUT"
echo "  Generated on: $DATE                                      " >> "$OUTPUT"
echo "  Author: $(whoami)                                        " >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write the personalised manifesto paragraph using string concatenation
echo "  Every day, I rely on $TOOL — a tool built not for profit," >> "$OUTPUT"
echo "  but for people. It was created by individuals who believed" >> "$OUTPUT"
echo "  that knowledge and code should be shared, not hoarded." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  To me, freedom means $FREEDOM. And in the world of software," >> "$OUTPUT"
echo "  that freedom is made real through open source — the right" >> "$OUTPUT"
echo "  to read the code, to change it, to share it, and to build" >> "$OUTPUT"
echo "  on the work of those who came before." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I believe in this philosophy enough that I would build" >> "$OUTPUT"
echo "  $BUILD and share it freely with the world — because the" >> "$OUTPUT"
echo "  software I depend on today exists because someone else" >> "$OUTPUT"
echo "  made that same choice before me." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open source is not just a license. It is a promise:" >> "$OUTPUT"
echo "  that what we build together belongs to all of us." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — $(whoami), $DATE" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Display the generated manifesto ---
echo "  [✔] Manifesto saved to: $OUTPUT"
echo ""
cat "$OUTPUT"
echo ""
echo "============================================================"
