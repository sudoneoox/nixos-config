{pkgs, ...}: {
  home.packages = with pkgs; [
    python312
  ];
  programs.uv = {
    enable = true;
    settings = {
      python-downloads = "never";
      python-preference = "only-system";
    };
  };
  # makes uv install binaries in ~/.local/bin
}
