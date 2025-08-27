{custom_vars, ...}: {
  services.printing.enable = custom_vars.FEATURES.ENABLE_PRINTING;
}
