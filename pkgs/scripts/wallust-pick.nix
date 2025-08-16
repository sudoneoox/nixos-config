{pkgs}:
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

    WALL_DIR="$HOME/Assets/nixos-config/Wallpapers"
    CFG_DIR="$HOME/.config/wallust"
    WAYBAR_CSS="$HOME/.cache/wallust/colors-waybar.css"


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

    #INFO: Apply via hyprpaper if running
    if pgrep -x hyprpaper >/dev/null 2>&1; then
      echo "[wallust-pick] applying via hyprpaper…"
      hyprctl hyprpaper reload ",''${SEL}" || true
    fi

    #INFO: Ensure template exists
    TEMPL_DIR="''${CFG_DIR}/templates"
    mkdir -p "''${TEMPL_DIR}" "''${HOME}/.cache/wallust"

    if [[ ! -f "''${TEMPL_DIR}/colors-waybar.css.hbs" ]]; then
      echo "[wallust-pick] missing ''${TEMPL_DIR}/colors-waybar.css.hbs"
      exit 1
    fi

    #INFO: Render with Wallust v3 using config dir
    echo "[wallust-pick] rendering wallust templates…"
    wallust -d "''${CFG_DIR}" run "''${SEL}"

    #INFO: Verify target exists
    if [[ -f "''${WAYBAR_CSS}" ]]; then
      echo "[wallust-pick] rendered: ''${WAYBAR_CSS}"
    else
      echo "[wallust-pick] warning: expected rendered ''${WAYBAR_CSS} not found"
      exit 2
    fi

    #INFO: Reload Waybar (USR2 makes it re-read CSS)
    if pgrep -f waybar >/dev/null 2>&1; then
      pkill -USR2 waybar || true
    fi

    #INFO: Notify
    notify-send "Wallpaper updated" "$(basename "''${SEL}")" || true
  '';
}
