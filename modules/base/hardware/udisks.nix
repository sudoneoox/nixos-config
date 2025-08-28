{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf config.x0.features.enableUdiskie {
    services.udisks2 = {
      enable = true;
    };
  };
}
