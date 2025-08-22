{ pkgs, ... }:

let
  kose-font = pkgs.callPackage ../../pkgs/fonts/kose.nix { };
  hugmetight-font = pkgs.callPackage ../../pkgs/fonts/hugmetight.nix { };
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji
    nerd-fonts.symbols-only
    nerd-fonts.hurmit
    nerd-fonts.monofur
    lxgw-wenkai
    maple-mono.NF
    font-awesome  # Add Font Awesome for additional icons
    kose-font  # Xiaolai Mono SC
    hugmetight-font  # Hug Me Tight
  ];
  
  fonts.fontDir.enable = true;
}