{pkgs}: let
  THUMB_PATH = "/tmp/hyde-mpris";
  THUMB_BLURRED_PATH = "/tmp/hyde-mpris-blurred";
  #NOTE: default player for playerctl --player
  # PLAYER = "cider";
  # Pick up any active player automatically
  PLAYER = "$(playerctl -l 2>/dev/null | head -n1 || true)";
in
  pkgs.writeShellApplication {
    name = "playerctl-lock";
    runtimeInputs = [
      pkgs.playerctl
      pkgs.curl
      pkgs.imagemagick
      pkgs.procps
      pkgs.coreutils
    ];
    text = ''
      set -Eeuo pipefail

      # Inject Nix values once; use shell vars after.
      THUMB='${THUMB_PATH}'
      THUMB_BLURRED='${THUMB_BLURRED_PATH}'
      PLAYER="${PLAYER}"

      usage() {
        printf 'Usage: %s --title | --artist | --position | --length | --album | --source\n' "$0"
      }

      # Always succeed; echo empty on error so strict mode doesn't kill us.
      get_metadata() {
        local key=''${1:-}
        playerctl metadata --player="${PLAYER}" --format "{{ ''${key} }}" 2>/dev/null || true
      }

      get_source_info() {
        local trackid
        trackid=$(get_metadata "mpris:trackid")
        if [[ "''${trackid}" == *firefox* ]]; then
          printf 'Firefox 󰈹\n'
        elif [[ "''${trackid}" == *spotify* ]]; then
          printf 'Spotify \n'
        elif [[ "''${trackid}" == *chromium* ]]; then
          printf 'Chrome \n'
        elif [[ "''${trackid}" == *YoutubeMusic* ]]; then
          printf 'YouTubeMusic \n'
        else
          printf '\n'
        fi
      }

      get_position() {
        playerctl position 2>/dev/null || true
      }

      convert_length() {
        local length=''${1:-0}
        local seconds=$(( length / 1000000 ))   # mpris:length is in µs
        local minutes=$(( seconds / 60 ))
        local remaining_seconds=$(( seconds % 60 ))
        printf '%d:%02d m' "''${minutes}" "''${remaining_seconds}"
      }

      convert_position() {
        local position=''${1:-0}
        local seconds=''${position%%.*}         # strip fractional part
        local minutes=$(( seconds / 60 ))
        local remaining_seconds=$(( seconds % 60 ))
        printf '%d:%02d' "''${minutes}" "''${remaining_seconds}"
      }

      fetch_thumb() {
        # Prefer the configured player; tolerate missing artUrl.
        local artUrl
        artUrl=$(playerctl -p "''${PLAYER}" metadata --format '{{mpris:artUrl}}' 2>/dev/null || true)
        [[ -z "''${artUrl}" ]] && return 0

        if [[ -f "''${THUMB}.inf" ]] && [[ "''${artUrl}" == "$(cat "''${THUMB}.inf")" ]]; then
          return 0
        fi

        printf '%s\n' "''${artUrl}" > "''${THUMB}.inf"

        if curl -fsSL -o "''${THUMB}.png" -- "''${artUrl}"; then
          # Recompress and make blurred background
          magick "''${THUMB}.png" -quality 50 "''${THUMB}.png"
          magick "''${THUMB}.png" -blur 200x7 -resize 1920x^ -gravity center -extent 1920x1080! "''${THUMB_BLURRED}.png"
          pkill -USR2 hyprlock 2>/dev/null || true
        else
          rm -f -- "''${THUMB}"* "''${THUMB_BLURRED}"* || true
        fi
      }

      if [[ $# -eq 0 ]]; then
        usage
        exit 1
      fi

      # Fire-and-forget (errors handled inside the function)
      fetch_thumb &

      case "''${1:-}" in
        --title)
          title=$(get_metadata "xesam:title")
          if [[ -z "''${title}" ]]; then
            printf '\n'
          else
            printf '%s\n' "''${title:0:50}"
          fi
          ;;
        --artist)
          artist=$(get_metadata "xesam:artist")
          if [[ -z "''${artist}" ]]; then
            printf '\n'
          else
            printf '%s\n' "''${artist:0:50}"
          fi
          ;;
        --position)
          position=$(get_position)
          length=$(get_metadata "mpris:length")
          if [[ -z "''${position}" || -z "''${length}" ]]; then
            printf '\n'
          else
            position_formatted=$(convert_position "''${position}")
            length_formatted=$(convert_length "''${length}")
            printf '%s/%s\n' "''${position_formatted}" "''${length_formatted}"
          fi
          ;;
        --length)
          length=$(get_metadata "mpris:length")
          if [[ -z "''${length}" ]]; then
            printf '\n'
          else
            convert_length "''${length}"; printf '\n'
          fi
          ;;
        --status)
          status=$(playerctl status 2>/dev/null || true)
          if [[ "''${status}" == "Playing" ]]; then
            printf '󰎆\n'
          elif [[ "''${status}" == "Paused" ]]; then
            printf '󱑽\n'
          else
            printf '\n'
          fi
          ;;
        --album)
          album=$(get_metadata "xesam:album")
          if [[ -n "''${album}" ]]; then
            printf '%s\n' "''${album}"
          else
            status=$(playerctl status 2>/dev/null || true)
            if [[ -n "''${status}" ]]; then
              printf 'Not album\n'
            else
              printf '\n'
            fi
          fi
          ;;
        --source)
          get_source_info
          ;;
        *)
          printf 'Invalid option: %s\n' "''${1:-}"
          usage
          exit 1
          ;;
      esac
    '';
  }
