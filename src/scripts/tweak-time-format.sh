#!/bin/bash

# Script to change the GDM clock format (12h or 24h)

print_help() {
    echo "Usage: $0 [12h|24h]"
    echo ""
    echo "Changes the GNOME Display Manager (GDM) clock format."
    echo ""
    echo "Arguments:"
    echo "  12h     Set clock to 12-hour format (e.g., 1:00 PM)"
    echo "  24h     Set clock to 24-hour format (e.g., 13:00)"
    echo "  --help  Show this help message and exit"
    echo ""
    echo "Example:"
    echo "  sudo $0 24h"
}

# Check for --help
if [[ "$1" == "--help" || "$1" == "-h" || -z "$1" ]]; then
    print_help
    exit 0
fi

# Validate argument
if [[ "$1" != "12h" && "$1" != "24h" ]]; then
    echo "Error: Invalid argument '$1'"
    echo "Use --help for usage."
    exit 1
fi

# Set clock format for GDM
echo "Setting GDM clock format to '$1'..."
sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface clock-format "$1"

if [[ $? -eq 0 ]]; then
    echo "✅ GDM clock format set to $1"
else
    echo "❌ Failed to set GDM clock format."
    exit 2
fi
