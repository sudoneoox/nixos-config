{
  pkgs,
  custom,
}: let
  WALLPAPER_DIR = "${custom.x0.nixosAssetsPath}/Wallpapers";
  CACHE_DIR = "${custom.x0.cachePath}";
in
  pkgs.writeShellApplication {
    name = "wallust-pick";

    #NOTE: Tools used in the script (ensures they're on PATH when it runs)
    runtimeInputs = [
      pkgs.findutils #NOTE: find
      pkgs.coreutils #NOTE: sort, mkdir, basename, etc.
      pkgs.fzf
      pkgs.chafa
      pkgs.wallust
      pkgs.hyprland-git.hyprland #NOTE: hyprctl
      pkgs.hyprpaper
      pkgs.procps #NOTE: pgrep, pkill
      pkgs.libnotify #NOTE: notify-send
    ];

    text = ''
      set -euo pipefail

      WALL_DIR=${WALLPAPER_DIR}
      CFG_DIR="$HOME/.config/wallust"

      # WARN: make sure to add your rendered outputs that you want to reload after walllust runs
      KITTY_COLORS="$HOME/.config/kitty/current-theme.conf"

      #NOTE: Build list (follow symlinks)
      mapfile -t files < <(find -L "$WALL_DIR" -type f \( \
        -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \
      \) | sort)

      if [[ ''${#files[@]} -eq 0 ]]; then
        echo "[wallust-pick] no images found in $WALL_DIR" >&2
        exit 1
      fi
      #INFO: Image preview with chafa
      FZF_PREVIEW_OPTS=(--preview "chafa --fill=block --symbols=block --size=80x40 {}")

      SEL="$(printf '%s\n' "''${files[@]}" | fzf --height=90% --layout=reverse \
        --prompt='Pick wallpaper ❯ ' --border=rounded --ansi "''${FZF_PREVIEW_OPTS[@]}")"

      [[ -z "''${SEL}" ]] && exit 0

      echo "[wallust-pick] selected: ''${SEL}"

      #INFO: Make it dynamic and noticeable of our current_wp for our other configurations
      echo "''${SEL}" > ${CACHE_DIR}/current_wp_path
      install -m 0644 -T -- "''${SEL}" ${CACHE_DIR}/current_wallpaper


      #INFO: Apply via hyprpaper if running
      if pgrep -x hyprpaper >/dev/null 2>&1; then
        echo "[wallust-pick] applying via hyprpaper…"
        #INFO: Reload current config and set new image (best-effor, ignore error)
        hyprctl hyprpaper reload ",''${SEL}" || true
      fi

      #INFO: render ALL templates declared in wallust.toml
      TEMPL_DIR="''${CFG_DIR}/templates"
      mkdir -p "''${TEMPL_DIR}" ${CACHE_DIR}/wallust ${CACHE_DIR}/wal
      echo "[wallust-pick] rendering wallust templates"
      wallust -d "''${CFG_DIR}" run "''${SEL}"

      #INFO: post-apply reloads (only when correspoding files actually exist)
      reloaded=()

      #INFO: waybar: if waybar runs, ask it to re-read CSS (USR2)
      if pgrep -f waybar >/dev/null 2>&1; then
        pkill -USR2 waybar || true
        reloaded+=("waybar")
      fi

      # INFO: Reload hyprland
      if pgrep -f hyprland >/dev/null 2>&1; then
        hyprctl reload || true
        reloaded+=("hyprland")
      fi

      #INFO: Kitty: if target exists and kitty is running, try live color reload
      if [[ -f "''${KITTY_COLORS}" ]] && pgrep -x kitty >/dev/null 2>&1; then
        #INFO: Prefer remote control (works if your kitty has a control socket; otherwise this no-ops)
        if kitty @ set-colors --all "''${KITTY_COLORS}" >/dev/null 2>&1; then
          reloaded+=("kitty")
        else
          #INFO: Optional: try a well-known socket name if you use one:
          # kitty @ --to unix:/tmp/kitty set-colors --all "''${KITTY_COLORS}" >/dev/null 2>&1 || true
          # If remote control isn't enabled, you'll need to restart kitty or enable:
          #   allow_remote_control yes
          #   listen_on unix:/tmp/kitty
          reloaded+=("kitty (restart needed)")
        fi
      fi

      #INFO: Notify
      if [[ ''${#reloaded[@]} -gt 0 ]]; then
        notify-send "Wallust applied" "$(basename "''${SEL}") → ''${reloaded[*]}"
      else
        notify-send "Wallust applied" "$(basename "''${SEL}")"
      fi
    '';
  }
