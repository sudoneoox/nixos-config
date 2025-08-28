{config, ...}: {
  time.timeZone = config.x0.timezone;

  i18n.defaultLocale = config.x0.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = config.x0.locale;
    LC_IDENTIFICATION = config.x0.locale;
    LC_MEASUREMENT = config.x0.locale;
    LC_MONETARY = config.x0.locale;
    LC_NAME = config.x0.locale;
    LC_NUMERIC = config.x0.locale;
    LC_PAPER = config.x0.locale;
    LC_TELEPHONE = config.x0.locale;
    LC_TIME = config.x0.locale;
  };
}
