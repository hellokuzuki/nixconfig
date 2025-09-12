{ config, pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        nixu = "nh os switch --ask .";
        homeu = "nh home switch --ask .";
        nixc = "sudo -E nh clean all --keep-since 7d --keep 5";
        # vim = "nvim";
        cd = "z";
      };
      shellAliases = {
        "ls" = "exa";
        "l" = "exa -lah --icons=auto";
      };
      shellInit = ''
        zoxide init fish | source
        export PATH="$HOME/.local/bin:$HOME/.juliaup/bin:$PATH"
        set -g fish_color_command blue --italics
        set -g fish_color_quote yellow --italics
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "pisces";
          src = pisces.src;
        }
      ];
      functions = {
        fish_greeting = "";
      };
    };
  };
  programs.man.generateCaches = false;
}