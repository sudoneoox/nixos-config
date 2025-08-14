#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="${HOME}/Assets/nixos-config/Wallpapers"
CFG_DIR="${HOME}/.config/wallust"
WAYBAR_CSS="${HOME}/.cache/wallust/colors-waybar.css"

have() { command -v "$1" >/dev/null 2>&1; }

# INFO: build list, FOLLOW symlinks
mapfile -t files < <(find -L "$WALL_DIR" -type f \( \
  -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \
  \) | sort)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "[wallust-pick] no images found in $WALL_DIR" >&2
  exit 1
fi

# INFO: image preview (needs chafa)
FZF_PREVIEW_OPTS=(--preview "chafa --fill=block --symbols=block --size=${FZF_PREVIEW_SIZE:-80x40} {}")

SEL="$(printf '%s\n' "${files[@]}" | fzf --height=90% --layout=reverse \
  --prompt='Pick wallpaper ❯ ' --border=rounded --ansi "${FZF_PREVIEW_OPTS[@]}")"

[[ -z "${SEL}" ]] && exit 0

echo "[wallust-pick] selected: ${SEL}"

# INFO: hyprpaper apply (if running)
if pgrep -x hyprpaper >/dev/null 2>&1 && have hyprpaper; then
  echo "[wallust-pick] applying via hyprpaper…"
  hyprctl hyprpaper reload ",${SEL}" || true
fi

# INFO: ensure template exists
TEMPL_DIR="${CFG_DIR}/templates"
mkdir -p "${TEMPL_DIR}" "${HOME}/.cache/wallust"

if [[ ! -f "${TEMPL_DIR}/colors-waybar.css.hbs" ]]; then
  echo "[wallust-pick] missing ${TEMPL_DIR}/colors-waybar.css.hbs"
  exit 1
fi

# INFO: Render with Wallust v3 using your CONFIG DIR (no --templates-dir; use -d)

echo "[wallust-pick] rendering wallust templates…"
wallust -d "${CFG_DIR}" run "${SEL}"

# Verify the configured target exists (WAYBAR_CSS must match wallust.toml)
if [[ -f "${WAYBAR_CSS}" ]]; then
  echo "[wallust-pick] rendered: ${WAYBAR_CSS}"
else
  echo "[wallust-pick] warning: expected rendered ${WAYBAR_CSS} not found"
  exit 2
fi

# INFO: Reload Waybar (USR2 makes it re-read css)
if pgrep -f waybar >/dev/null 2>&1 && have pkill; then
  pkill -USR2 waybar || true
fi

# Notify
have notify-send && notify-send "Wallpaper updated" "$(basename "${SEL}")" || true
