#!/usr/bin/env python3
from gi.repository import Gio, GLib
import subprocess
import gi
gi.require_version('Gio', '2.0')

# Define your themes
LIGHT_THEME = "WhiteSur-Light-solid"
DARK_THEME = "WhiteSur-Dark-solid"


def set_shell_theme(theme_name):
    subprocess.run([
        "gsettings",
        "set",
        "org.gnome.shell.extensions.user-theme",
        "name",
        theme_name
    ])


def on_color_scheme_changed(settings, key):
    value = settings.get_string(key)
    if value == "prefer-dark":
        set_shell_theme(DARK_THEME)
    else:
        set_shell_theme(LIGHT_THEME)


def main():
    settings = Gio.Settings.new("org.gnome.desktop.interface")
    settings.connect("changed::color-scheme", on_color_scheme_changed)

    # Initial check
    on_color_scheme_changed(settings, "color-scheme")

    loop = GLib.MainLoop()
    loop.run()


if __name__ == "__main__":
    main()
