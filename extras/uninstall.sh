#!/bin/bash
# Removes the Olympus theme-set hook and puts back your previous About and
# screensaver art.
set -euo pipefail

HOOK="$HOME/.config/omarchy/hooks/theme-set.d/olympus-branding.sh"
if [[ -f $HOOK ]]; then
  bash "$HOOK" ""   # any theme other than olympus restores the originals
  rm -f -- "$HOOK"
fi
echo "Olympus extras removed."
