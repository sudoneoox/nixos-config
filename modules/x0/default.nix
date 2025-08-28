# x0/default.nix
{
  imports = [
    ./options.nix
    ./derived.nix
  ];

  config.x0 = import ./values.nix;
}
