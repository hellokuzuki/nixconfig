{ config, pkgs, ... }:

{
  imports = [
    ./programs
    ./packages.nix
    ./programs.nix
  ];

  home.username = "mark";
  home.homeDirectory = "/home/mark";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}