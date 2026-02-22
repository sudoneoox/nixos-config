{
  custom,
  lib,
  inputs,
  ...
}: let
  x = custom.x0;
in {
  imports = [inputs.nixcord.homeModules.nixcord];
  config = lib.mkIf x.features.enableNixcord {
    programs.nixcord = {
      enable = x.features.enableNixcord;
      vesktop = {
        enable = true;
        configDir = "${x.derived.homeDir}/.config/vesktop";
      };
      config = {
        enableReactDevtools = false;
        autoUpdate = false;
        autoUpdateNotification = false;
        disableMinSize = true;
        frameless = true;
        notifyAboutUpdates = false;
        themeLinks = [
          "https://s-k-y-l-i.github.io/discord-themes/Smooth-Harmony.theme.css"
          "https://s-k-y-l-i.github.io/discord-themes/Acrylic-Harmony.theme.css"
          "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
        ];
        plugins = {
          USRBG = {
            enable = true;
            nitroFirst = true;
            voiceBackground = true;
          };

          alwaysAnimate.enable = true;
          anonymiseFileNames.enable = true;
          BlurNSFW.enable = true;
          ClearURLs.enable = true;
          expressionCloner.enable = true;
          experiments.enable = true;
          fakeNitro.enable = true;
          #invisibleChat.enable = true;
          messageLogger = {
            enable = true;
            collapseDeleted = true;
            deleteStyle = "overlay";
            ignoreBots = true;
          };
          moyai.enable = true;
        };
      };
      configDir = "${x.derived.homeDir}/.config/Vencord";
      discord = {
        branch = "canary";
        configDir = "${x.derived.homeDir}/.config/discord";
      };
    };
  };
}
