#!/bin/bash

# Install Omagtk for the current user without a package. On Arch, prefer the
# package (see README); this is for other setups and for hacking on the theme.
#
#   ./install.sh          copy into ~/.local and set up
#   ./install.sh --link   link to this checkout instead, so edits apply live

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$HOME/.local/share/omagtk"
BIN="$HOME/.local/bin/omagtk"

mkdir -p "$(dirname "$BIN")"
rm -rf "$DATA_DIR" "$BIN"

if [[ ${1:-} == "--link" ]]; then
  # Run from the checkout, the script uses the checkout's theme files.
  ln -s "$SRC/bin/omagtk" "$BIN"
else
  mkdir -p "$DATA_DIR"
  cp -r "$SRC/theme" "$SRC/hooks" "$DATA_DIR/"
  install -m 755 "$SRC/bin/omagtk" "$BIN"
fi

"$BIN" setup
