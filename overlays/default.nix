{ inputs, ... }:

{
  modifications = final: prev: {
    awesome = inputs.nixpkgs-f2k.packages.${prev.system}.awesome-luajit-git;
    hyprland-git = inputs.hyprland.packages.${prev.system};
    hyprland-plugins = inputs.hyprland.packages.${prev.system};
    sawm = inputs.sawm.packages.${prev.system}.default;
    sfish = inputs.sfish.packages.${prev.system}.default;
    snvim = inputs.snvim.packages.${prev.system}.default;
    skitty = inputs.skitty.packages.${prev.system}.default;
    hyprland-git = inputs.hyprland.packages.${prev.system};
    hyprlnad-plugins = inputs.hyprland-pluugins.packages.${prev.system};
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nur = inputs.nur.overlays.default;

}
