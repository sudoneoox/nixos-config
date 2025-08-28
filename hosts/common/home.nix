{
  outputs,
  config,
  inputs,
  ...
}: let
  x = config.x0;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ../../modules/home/devel
    ../../modules/home/desktop/zen-browser
    ../../modules/home/desktop/hyprland
    ../../modules/home/desktop/cursors
    ../../modules/home/utils
  ];

  fonts.fontconfig.enable = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.additions
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "${x.username}";
    homeDirectory = "/home/${x.username}";
  };

  programs = {
    home-manager.enable = true;
  };
  systemd.user.startServices = "sd-switch";
}
