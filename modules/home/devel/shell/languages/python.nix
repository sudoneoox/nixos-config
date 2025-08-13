{pkgs, ...}: {
  home.package = with pkgs; [
    python312
  ];
}
