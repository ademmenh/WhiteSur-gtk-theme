#!/bin/bash

#Tweak the icon theme for GDM (Gnome Display Manager)

usage() {
    echo "Usage: $0 <icon-theme-name>"
    echo "       $0 -h      Show this help message"
}

# Handle -h flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Validation
if [ -z "$1" ]; then
    echo "Error: No icon theme specified."
    usage
    exit 1
fi

ICON_THEME="$1"

# Apply the icon theme for GDM user
sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

# Check exit status
if [ $? -eq 0 ]; then
    echo "Icon theme set to '$ICON_THEME' for GDM user."
else
    echo "Failed to set icon theme."
    exit 2
fi
