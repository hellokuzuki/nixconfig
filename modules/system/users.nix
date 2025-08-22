{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.mark = {
    isNormalUser = true;
    description = "mark";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      git
      vim
      curl
      nodejs
      vscode
    ];
  };
}