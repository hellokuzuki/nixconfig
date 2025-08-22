{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Enable shells
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    claude-code
    google-chrome
    slack
    teams-for-linux
    mysql-workbench
    postman
    awscli2
    
    # Hyprland essentials
    waybar
    rofi-wayland
    dunst
    swww
    kitty
    wl-clipboard
    grim
    slurp
    swaylock-effects
    swayidle
    brightnessctl
    pamixer
    playerctl
    networkmanagerapplet
    blueman
    pavucontrol
    
    # Power management GUI tools
    gnome-tweaks
    gnome-control-center
    gnome-settings-daemon
    gnome-shell-extensions
    gnomeExtensions.system-monitor
    gnome-calendar
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
}