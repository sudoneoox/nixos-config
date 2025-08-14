#!/usr/bin/env bash
set -euo pipefail

# CONFIG — change to your wallpapers dir
WALL_DIR="${HOME}/Assets/nixos-config/Wallpapers"

# Deps we try to use
have() { command -v "$1" >/dev/null 2>&1; }

if ! have fzf; then
  echo "[wallust-pick] error: fzf is required" >&2
  exit 1
fi

# Build the fzf command with optional image preview (chafa) if available.
FZF_PREVIEW=''
if have chafa; then
  # Render a preview (fits terminal size automatically)
  FZF_PREVIEW="--preview 'chafa --fill=block --symbols=block --size=${FZF_PREVIEW_SIZE:-80x40} {}'"
fi

# Collect candidate images (common extensions)
mapfile -t files < <(find "$WALL_DIR" -type f \( \
  -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \
  \) | sort)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "[wallust-pick] no images found in $WALL_DIR" >&2
  exit 1
fi

# Picker
SEL="$(printf '%s\n' "${files[@]}" | fzf --height=90% --layout=reverse \
  --prompt='Pick wallpaper ❯ ' --border=rounded --ansi ${FZF_PREVIEW})"

if [[ -z "${SEL}" ]]; then
  echo "[wallust-pick] cancelled."
  exit 0
fi

echo "[wallust-pick] selected: ${SEL}"

# 1) Try to set it via hyprpaper (if running)
if pgrep -x hyprpaper >/dev/null 2>&1 && have hyprpaper && have jq && have hyprctl; then
  echo "[wallust-pick] applying via hyprpaper…"
  # Preload once (safe to call repeatedly)
  hyprpaper preload "${SEL}" || true

  # Set on all monitors
  mapfile -t mons < <(hyprctl -j monitors | jq -r '.[].name')
  for m in "${mons[@]}"; do
    hyprpaper wallpaper "$m,${SEL}" || true
  done
else
  echo "[wallust-pick] hyprpaper not detected (or jq/hyprctl missing); skipping wallpaper apply."
fi

# 2) Regenerate palette from the chosen file
if have wallust; then
  echo "[wallust-pick] regenerating wallust palette…"
  wallust -f "${SEL}"
else
  echo "[wallust-pick] wallust not found; skipping palette generation."
fi

# 3) Reload waybar so CSS picks up ~/.cache/wallust/colors-waybar.css
if pgrep -x waybar >/dev/null 2>&1 && have pkill; then
  echo "[wallust-pick] reloading waybar…"
  pkill -USR2 waybar || true
fi

# Optional desktop notification
if have notify-send; then
  notify-send "Wallpaper updated" "$(basename "${SEL}")" || true
fi

echo "[wallust-pick] done."
