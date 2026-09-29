#!/bin/bash

# Remove a ./install.sh install of Omagtk and switch GTK back to Adwaita.

set -euo pipefail

if [[ -x $HOME/.local/bin/omagtk ]]; then
  "$HOME/.local/bin/omagtk" remove
fi

rm -rf "$HOME/.local/share/omagtk" "$HOME/.local/bin/omagtk"
