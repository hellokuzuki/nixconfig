{ config, pkgs, ... }:

{
  # Install Neovide package
  home.packages = with pkgs; [
    neovide
  ];

  # Neovide configuration file
  xdg.configFile."neovide/config.toml".text = ''
    [font]
    normal = ["Maple Mono NF"]
    size = 14.0

    [window]
    transparency = 0.95
    blur = true

    [cursor]
    animation_length = 0.13
    trail_size = 0.8
    antialiasing = true
    vfx_mode = "railgun"

    [misc]
    hide_mouse_when_typing = true
  '';
}