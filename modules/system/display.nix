{ config, pkgs, lib, ... }:

{
  # Handle lid switch events - don't suspend when lid is closed if external monitor is connected
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };

  # Install necessary tools for display management
  environment.systemPackages = with pkgs; [
    wlr-randr  # Wayland display configuration tool
    kanshi     # Dynamic display configuration for Wayland
  ];

  # Enable kanshi service for automatic display configuration
  # Kanshi will handle display switching when lid is closed/opened
  systemd.user.services.kanshi = {
    description = "Dynamic display configuration";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      RestartSec = 5;
      Restart = "always";
    };
  };

  # Create kanshi configuration directory
  system.userActivationScripts.kanshiConfig = ''
    mkdir -p $HOME/.config/kanshi
  '';
}