{
  X0,
  lib,
  ...
}: {
  config = lib.mkIf X0.FEATURES.ENABLE_UDISKIE {
    services.udisks2 = {
      enable = true;
    };
  };
}
