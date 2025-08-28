{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  x = config.x0;
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  home.packages = lib.mkIf (config.x0.colorScheme == "wallust") [
    pkgs.pywalfox-native
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };
}
