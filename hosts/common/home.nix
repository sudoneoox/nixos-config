{
  outputs,
  config,
  inputs,
  ...
}: {
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
    username = "${config.x0.username}";
    homeDirectory = "/home/${config.x0.username}";
  };

  programs = {
    home-manager.enable = true;
  };
  systemd.user.startServices = "sd-switch";
}
