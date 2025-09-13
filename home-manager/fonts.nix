{ config, pkgs, ... }:

let
  kose-font = pkgs.callPackage ../pkgs/fonts/kose.nix { };
in
{
  # Install required fonts
  home.packages = with pkgs; [
    lxgw-wenkai
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji
    nerd-fonts.symbols-only
    nerd-fonts.hurmit
    nerd-fonts.monofur
    # maple-mono.NF
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
    font-awesome
    kose-font  # Xiaolai fonts (XiaolaiSC and XiaolaiMonoSC)
  ];

  # Enable fontconfig and set default fonts
  fonts.fontconfig.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Maple Mono NF" "XiaolaiMonoSC" ];
      sansSerif = [ "Noto Sans" "XiaolaiSC" ];
      serif = [ "Noto Serif" "XiaolaiSC" ];
    };
  };
}
