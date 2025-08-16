{pkgs}:
pkgs.writeShellApplication {
  name = "hypr-restore-window";
  runtimeInputs = [
    pkgs.hyprland-git.hyprland #NOTE: hyprctl
    pkgs.jq
    pkgs.fzf
    pkgs.gawk #NOTE: for awk
    pkgs.coreutils #NOTE: printf, head, etc.
  ];
  text = ''
    monitor_prefix="''${1-}"
    active_ws="$(hyprctl activeworkspace -j | jq '.id')"
    target_ws="$((10 + active_ws))"

    address="$(
      hyprctl -j clients \
      | jq -r --argjson target_ws "$target_ws" '
          .[] | select(.workspace.id == $target_ws) | "\(.address)\t\(.title)"
        ' \
      | fzf \
          --preview 'hyprctl -j clients | jq -r ".[] | select(.address == \"{1}\") | \"address: \(.address)\ntitle: \(.title)\nclass: \(.class)\nworkspace: \(.workspace.id)\ntags: \(.tags)\""' \
          --preview-window=down:50%:wrap \
          --layout=reverse -d $'\t' --with-nth=2 \
      | awk -F'\t' '{print $1}'
    )"

    if [ -n "$address" ]; then
      hyprctl dispatch untag address:"$address" minimized
      hyprctl dispatch "''${monitor_prefix}"movetoworkspacesilent "$active_ws",address:"$address"
      hyprctl dispatch focuswindow address:"$address"
    fi
  '';
}
