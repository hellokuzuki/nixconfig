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
    
    # Email
    mailspring  # Modern email client with Outlook support

  ];
}