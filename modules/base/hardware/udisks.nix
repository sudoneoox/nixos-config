{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf x.features.enableUdiskie {
    services.udisks2 = {
      enable = true;
    };
  };
}
