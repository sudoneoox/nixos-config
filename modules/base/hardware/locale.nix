{custom_vars, ...}: {
  time.timeZone = custom_vars.TIMEZONE;

  i18n.defaultLocale = custom_vars.LOCALE;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = custom_vars.LOCALE;
    LC_IDENTIFICATION = custom_vars.LOCALE;
    LC_MEASUREMENT = custom_vars.LOCALE;
    LC_MONETARY = custom_vars.LOCALE;
    LC_NAME = custom_vars.LOCALE;
    LC_NUMERIC = custom_vars.LOCALE;
    LC_PAPER = custom_vars.LOCALE;
    LC_TELEPHONE = custom_vars.LOCALE;
    LC_TIME = custom_vars.LOCALE;
  };
}
