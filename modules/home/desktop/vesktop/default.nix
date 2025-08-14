{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "canary";
      tray = true;
      minimizeToTray = true;
      clickTrayToShow = true;
      disableMinSize = true;
      openLinksWithElectron = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      arRPC = true;
      appBade = true;
      enableSplashScreen = true;
      customTitleBar = false;
      checkUpdates = false;
      staticTitle = true;
    };
  };
}
