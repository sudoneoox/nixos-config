{pkgs, ...}: {
  home.packages = with pkgs; [
    python312
    uv
  ];
  # makes uv install binaries in ~/.local/bin
}
