{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/desktop.nix
    ../../modules/system/display.nix
    ../../modules/system/tuigreet.nix
    ../../modules/system/packages.nix
    ../../modules/system/users.nix
    ../../modules/system/fonts.nix
    ../../modules/system/nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.05";
}