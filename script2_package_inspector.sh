#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: [KRISH BISEN] | Roll: [24BCY10180]
# Course: Open Source Software | VITyarthi
# Description: Checks if a FOSS package is installed, displays
#              its version and license, and prints a philosophy
#              note about the package using a case statement.
# =============================================================

# --- Define the package to inspect ---
PACKAGE="git"   # Our chosen software for this audit

echo "============================================================"
echo "           FOSS PACKAGE INSPECTOR — $PACKAGE               "
echo "============================================================"
echo ""

# --- Check if the package is installed using if-then-else ---
# Try dpkg first (Debian/Ubuntu), then rpm (Fedora/RHEL/CentOS)
if command -v dpkg &>/dev/null; then
    # Debian/Ubuntu-based system: use dpkg -l to check installation
    if dpkg -l "$PACKAGE" &>/dev/null; then
        echo "  [✔] $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  --- Package Details ---"
        # Extract Version and Description using dpkg and grep
        dpkg -s "$PACKAGE" | grep -E 'Version|Status|Maintainer|Homepage'
    else
        echo "  [✘] $PACKAGE is NOT installed."
        echo "  To install, run: sudo apt install $PACKAGE"
        exit 1
    fi

elif command -v rpm &>/dev/null; then
    # RPM-based system (Fedora/CentOS/RHEL): use rpm -qi
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  [✔] $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  --- Package Details ---"
        # Extract key metadata from rpm query
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|URL'
    else
        echo "  [✘] $PACKAGE is NOT installed."
        echo "  To install, run: sudo dnf install $PACKAGE"
        exit 1
    fi
else
    # Fallback: try the git command directly if no package manager found
    if command -v git &>/dev/null; then
        echo "  [✔] $PACKAGE is INSTALLED (detected via command)."
        echo ""
        echo "  Version: $(git --version)"
    else
        echo "  Cannot determine package manager. Please check manually."
        exit 1
    fi
fi

echo ""
echo "  --- Installed Version ---"
# Get version directly from the git binary (works on all distros)
git --version

echo ""
echo "  --- Open Source Philosophy Note ---"

# --- Case statement: print philosophy note based on package name ---
case $PACKAGE in
    git)
        echo "  Git: Born in 2005 when Linus Torvalds lost access to"
        echo "  BitKeeper (a proprietary VCS). He built Git in just"
        echo "  10 days — proving open source can outpace proprietary."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Powers ~30% of all websites — built entirely in the open."
        ;;
    mysql | mariadb)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual-license model is a fascinating study in FOSS."
        ;;
    vlc)
        echo "  VLC: Built by French students who just wanted to watch"
        echo "  campus TV — now plays anything, everywhere, for free."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web"
        echo "  against massive corporate browser monopolies."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by its community."
        echo "  Its PSF license is one of the most permissive in FOSS."
        ;;
    *)
        # Default case if package name doesn't match any above
        echo "  $PACKAGE: An open-source tool contributing to the"
        echo "  global ecosystem of freely shared software."
        ;;
esac

echo ""
echo "============================================================"
