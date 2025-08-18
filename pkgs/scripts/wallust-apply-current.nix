{
  pkgs,
  custom_vars,
}: let
  WALLPAPER_PATH = "${custom_vars.NIXOS_ASSETS_PATH}/Wallpapers/${custom_vars.WALLPAPER}";
in
  pkgs.writeShellApplication {
    name = "wallust-apply-current";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.wallust
      pkgs.procps # pgrep/pkill
      pkgs.hyprland-git.hyprland # hyprctl
      pkgs.hyprpaper
      pkgs.libnotify # notify-send (optional)
    ];
    text = ''
      set -euo pipefail

      CFG_DIR="$HOME/.config/wallust"
      TEMPL_DIR="$CFG_DIR/templates"
      KITTY_COLORS="$HOME/.config/kitty/current-theme.conf"
      WP="${WALLPAPER_PATH}"

      mkdir -p "$TEMPL_DIR" "$HOME/.cache/wallust"

      if [[ ! -f "$WP" ]]; then
        echo "[wallust-apply-current] wallpaper not found: $WP" >&2
        exit 0
      fi

      echo "[wallust-apply-current] running wallust on $WP"
      wallust -d "$CFG_DIR" run "$WP"

      #INFO:Optional: light post-apply nudges if apps are already running.
      if pgrep -f waybar >/dev/null 2>&1; then
        pkill -USR2 waybar || true
      fi

      if pgrep -f hyprland >/dev/null 2>&1; then
        hyprctl reload || true
      fi

      if [[ -f "$KITTY_COLORS" ]] && pgrep -x kitty >/dev/null 2>&1; then
        kitty @ set-colors --all "$KITTY_COLORS" >/dev/null 2>&1 || true
      fi

      notify-send "Wallust applied at login" "$(basename "$WP")" || true
    '';
  }
