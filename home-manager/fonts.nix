{ config, pkgs, ... }:

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
  ];

  # Enable fontconfig and set default fonts
  fonts.fontconfig.enable = true;

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Maple Mono NF" "lxgw-wenkai" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };

    # # Apply lxgw-wenkai for Chinese text
    # langOverrides = {
    #   "zh" = [ "lxgw-wenkai" ];
    # };
  };
}
