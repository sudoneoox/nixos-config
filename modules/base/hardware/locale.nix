{config, ...}: let
  x = config.x0;
in {
  time.timeZone = x.timezone;

  i18n.defaultLocale = x.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = x.locale;
    LC_IDENTIFICATION = x.locale;
    LC_MEASUREMENT = x.locale;
    LC_MONETARY = x.locale;
    LC_NAME = x.locale;
    LC_NUMERIC = x.locale;
    LC_PAPER = x.locale;
    LC_TELEPHONE = x.locale;
    LC_TIME = x.locale;
  };
}
