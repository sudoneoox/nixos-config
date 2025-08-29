{
  pkgs,
  custom,
}: let
  WALLPAPER_PATH = "${custom.x0.nixosAssetsPath}/Wallpapers/${custom.x0.ux.wallpaper}";
  CACHE_DIR = "${custom.x0.cachePath}";
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
      WP=${WALLPAPER_PATH}

      mkdir -p "$TEMPL_DIR" "$HOME/.cache/wallust"

      if [[ ! -f "$WP" ]]; then
        echo "[wallust-apply-current] wallpaper not found: $WP" >&2
        exit 0
      fi

      #INFO: Make it dynamic and noticeable of our current_wp for our other configurations
      echo ${WALLPAPER_PATH} > ${CACHE_DIR}/current_wp_path
      install -m 0644 -T -- ${WALLPAPER_PATH} ${CACHE_DIR}/current_wallpaper

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
