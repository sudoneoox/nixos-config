{
  inputs,
  X0,
  ...
}: {
  modifications = final: prev: {
    hyprland-git = inputs.hyprland.packages.${prev.system};
    hyprland-plugins = inputs.hyprland-plugins.packages.${prev.system};
    hy3 = inputs.hy3.packages.${prev.system}.hy3;
    hyprland-smw = inputs.split-monitor-workspaces.packages.${prev.system}.split-monitor-workspaces;
    zen-browser-twilight = inputs.zen-browser.packages.${prev.system}.specific.twilight;
  };

  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      inherit X0;
    };

  #INFO: When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
