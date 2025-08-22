{ config, pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=WebUIDarkMode"
      "--force-dark-mode"
      "--gtk-version=4"
    ];
  };
  
  # Chrome flags file for additional dark mode settings
  home.file.".config/chrome-flags.conf".text = ''
    --enable-features=WebUIDarkMode
    --force-dark-mode
    --gtk-version=4
  '';
}