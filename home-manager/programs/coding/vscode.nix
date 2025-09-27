{ config, pkgs, ... }:

{
  # Install VS Code itself
  home.packages = with pkgs; [
    vscode
  ];

  # Configure VS Code through Home Manager
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Themes
        catppuccin.catppuccin-vsc

        # Language Support
        # vscodevim.vim
        yzhang.markdown-all-in-one
        bbenoist.nix  # Nix language support
        
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "editor.fontFamily" = "'Maple Mono NF', Consolas, 'Courier New', monospace";
        "editor.fontSize" = 16;
        "terminal.integrated.fontSize" = 16;
        "window.zoomLevel" = 1;
      };
    };
  };
}

