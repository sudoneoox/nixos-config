{inputs, ...}:
{
  imports = [
    ./git
    ./kitty
    ./shell
    ./starship
    ./nvim
    inputs.nixcats-local.homeModules.default
  ];
}
