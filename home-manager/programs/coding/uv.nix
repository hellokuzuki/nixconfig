{ config, pkgs, ... }:

{
  programs.uv = {
    enable = true;
    # uv settings can be configured here
    # settings = {
    #   # Example settings (uncomment as needed):
    #   # pip.index-url = "https://pypi.org/simple";
    # };
  };
}
