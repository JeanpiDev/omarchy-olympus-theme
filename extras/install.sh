#!/bin/bash
# Opt-in extras for the Olympus theme: installs a theme-set hook that swaps the
# About and screensaver art while Olympus is active. Run it yourself; installing
# the theme never runs code.
set -euo pipefail

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

omarchy hook install theme-set "$DIR/olympus-branding.sh"
bash "$HOME/.config/omarchy/hooks/theme-set.d/olympus-branding.sh" "$(cat "$HOME/.local/state/omarchy/current/theme.name" 2>/dev/null || true)"

echo "Olympus extras installed. Open About (fastfetch) or the screensaver to see them."
echo "Optional boot/login logo (asks for your password):"
echo "  omarchy plymouth set-by-theme olympus"
