{ config, pkgs, ... }:

{
  imports = [
    ./nh.nix
  ];

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    
    # Garbage collection disabled - using NH's clean feature instead
    gc = {
      automatic = false;
    };
  };
}