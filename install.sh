#!/bin/bash

# Install Omagtk for the current user.
#
#   ./install.sh          copy the theme, script and hook into place
#   ./install.sh --link   symlink them to this checkout instead (for hacking)

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DIR="$HOME/.local/share/themes/Omagtk"
BIN_DIR="$HOME/.local/bin"
HOOK_DIR="$HOME/.config/omarchy/hooks/theme-set.d"

link=0
[[ ${1:-} == "--link" ]] && link=1

place() {
  local from="$1" to="$2"

  mkdir -p "$(dirname "$to")"
  rm -rf "$to"
  if (( link )); then
    ln -s "$from" "$to"
  else
    cp -r "$from" "$to"
  fi
}

place "$SRC/theme" "$THEME_DIR"
place "$SRC/bin/omagtk-apply" "$BIN_DIR/omagtk-apply"
place "$SRC/hooks/omagtk" "$HOOK_DIR/omagtk"

"$BIN_DIR/omagtk-apply"

echo "Omagtk installed and active. It will follow every Omarchy theme change."
