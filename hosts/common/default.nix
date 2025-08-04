{
  username,
  outputs,
  inputs,
  email,
  pkgs,
  ...
}:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    ../../modules/base
  ];

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    source-code-pro
  ];

  fonts.enableDefaultPackages = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  home-manager = {
    backupFileExtension = "hm-backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        username
        email
        ;
    };
    users.${username} = {
      imports = [
        ./home.nix
      ];
    };
  };

}
