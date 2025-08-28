{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.x0.features.enableUdiskie {
    services.udisks2 = {
      enable = true;
    };
  };
}
