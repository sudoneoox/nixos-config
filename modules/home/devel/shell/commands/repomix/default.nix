{pkgs, ...}: {
  home.packages = [pkgs.repomix];
  xdg.configFile."repomix/repomix.config.json".source = ./repomix.config.json;
}
