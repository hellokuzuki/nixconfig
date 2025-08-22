{ config, pkgs, ... }:

{
  # NH - Nix Helper for better nix/nixos CLI experience
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/mark/flakes";
  };

  # Install nh package
  environment.systemPackages = with pkgs; [
    nh
  ];
}