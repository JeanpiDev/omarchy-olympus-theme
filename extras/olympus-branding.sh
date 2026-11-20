#!/bin/bash
# Olympus theme-set hook.
# While Olympus is the active theme, the About screen (fastfetch) shows the
# Olympus temple and the screensaver shows the temple with ΟΛΥΜΠΟΣ. Switching
# to any other theme puts back whatever was there before.
#
# Omarchy runs this with the new theme's slug in $1.

set -u

SRC="$HOME/.config/omarchy/themes/olympus/extras"
DST="$HOME/.config/omarchy/branding"
SAVE="$HOME/.local/state/omarchy/olympus-branding"
OMARCHY_DIR="${OMARCHY_PATH:-/usr/share/omarchy}"

# branding file -> Omarchy default used when there is nothing saved to restore
declare -A DEFAULTS=([about.txt]="$OMARCHY_DIR/icon.txt" [screensaver.txt]="$OMARCHY_DIR/logo.txt")

if [[ ${1:-} == olympus && -d $SRC ]]; then
  mkdir -p "$SAVE" "$DST"
  for f in "${!DEFAULTS[@]}"; do
    [[ -f $SRC/$f ]] || continue
    # Keep the user's own art once, unless it is already ours.
    if [[ ! -e $SAVE/$f && -f $DST/$f ]] && ! cmp -s "$DST/$f" "$SRC/$f"; then
      cp -- "$DST/$f" "$SAVE/$f"
    fi
    cp -- "$SRC/$f" "$DST/$f"
  done
else
  for f in "${!DEFAULTS[@]}"; do
    # Only undo our own change: if the user edited the file meanwhile, leave it.
    if [[ -f $SRC/$f ]] && cmp -s "$DST/$f" "$SRC/$f"; then
      if [[ -f $SAVE/$f ]]; then
        cp -- "$SAVE/$f" "$DST/$f"
      elif [[ -f ${DEFAULTS[$f]} ]]; then
        cp -- "${DEFAULTS[$f]}" "$DST/$f"
      fi
    fi
    rm -f -- "$SAVE/$f"
  done
fi

exit 0
