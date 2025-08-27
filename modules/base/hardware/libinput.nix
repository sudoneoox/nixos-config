{
  custom_vars,
  lib,
  ...
}: {
  config = lib.mkIf (custom_vars.SYSTEM.HOST_PROFILE == "laptop") {
    services = {
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
