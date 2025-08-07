{ inputs, ... }:

{

  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    awesome = inputs.nixpkgs-f2k.packages.${prev.system}.awesome-luajit-git;
    sawm = inputs.sawm.packages.${prev.system}.default;
    sfish = inputs.sfish.packages.${prev.system}.default;
    snvim = inputs.snvim.packages.${prev.system}.default;
    skitty = inputs.skitty.packages.${prev.system}.default;
    hyprspace = inputs.Hyprspace.packages.${prev.system}.default;
    hyprland-git = inputs.hyprland.packages.${prev.system};
    hyprland-plugins = inputs.hyprland-plugins.packages.${prev.system};
    hy3 = inputs.hy3.packages.${prev.system}.hy3;
    split-monitor-workspaces = inputs.split-monitor-workspaces.packages.${prev.system}.split-monitor-workspaces;
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nur = inputs.nur.overlays.default;

}
