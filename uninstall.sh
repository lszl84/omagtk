#!/bin/bash

# Remove Omagtk and hand GTK back to Omarchy's default (Adwaita).

set -euo pipefail

rm -rf "$HOME/.local/share/themes/Omagtk"
rm -f "$HOME/.local/bin/omagtk-apply"
rm -f "$HOME/.config/omarchy/hooks/theme-set.d/omagtk"

if command -v omarchy-theme-set-gnome >/dev/null; then
  omarchy-theme-set-gnome
else
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
fi

echo "Omagtk removed."
