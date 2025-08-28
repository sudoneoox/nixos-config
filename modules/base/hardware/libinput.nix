{
  config,
  lib,
  ...
}: let
  x = config.x0;
in {
  config = lib.mkIf (config.x0.system.hostProfile == "laptop") {
    services = {
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
