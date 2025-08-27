{X0, ...}: {
  time.timeZone = X0.TIMEZONE;

  i18n.defaultLocale = X0.LOCALE;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = X0.LOCALE;
    LC_IDENTIFICATION = X0.LOCALE;
    LC_MEASUREMENT = X0.LOCALE;
    LC_MONETARY = X0.LOCALE;
    LC_NAME = X0.LOCALE;
    LC_NUMERIC = X0.LOCALE;
    LC_PAPER = X0.LOCALE;
    LC_TELEPHONE = X0.LOCALE;
    LC_TIME = X0.LOCALE;
  };
}
