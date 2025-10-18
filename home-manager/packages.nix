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

    # VPN
    openvpn

    # AWS
    awscli2
    ssm-session-manager-plugin

    #Terraform
    terraform

    # Docker
    docker-compose

    # Python
    python3
    
    # Node.js
    nodejs_22
    
    # LSP servers for Neovim
    nil  # Nix LSP
    lua-language-server  # Lua LSP
    nodePackages.typescript-language-server  # TypeScript/JavaScript
    pyright  # Python (not under nodePackages)

    # Development IDEs
    jetbrains.idea-community
  ];
}