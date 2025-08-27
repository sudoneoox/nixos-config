{
  custom_vars,
  lib,
  ...
}: {
  config = lib.mkIf custom_vars.custom_vars.FEATURES.ENABLE_UDISKIE {
    services.udisks2 = {
      enable = true;
    };
  };
}
