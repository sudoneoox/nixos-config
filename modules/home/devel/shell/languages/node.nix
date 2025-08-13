{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
  ];
}
