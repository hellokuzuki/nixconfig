{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    htop
    #files
    zip
    xz
    unzip
    #utils
    ripgrep
    zoxide
    fzf
    eza
    fd
    btop

    nh
    
    # Python
    python3
    
    # Node.js
    nodejs_22
    
    # LSP servers for Neovim
    nil  # Nix LSP
    lua-language-server  # Lua LSP
    nodePackages.typescript-language-server  # TypeScript/JavaScript
    pyright  # Python (not under nodePackages)
  ];
}