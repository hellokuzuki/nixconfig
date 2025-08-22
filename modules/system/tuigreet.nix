{ config, pkgs, lib, ... }:
{
  # Disable SDDM since we're using greetd/tuigreet
  services.displayManager.sddm.enable = lib.mkForce false;
  
  # Enable greetd with tuigreet
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = let
        inherit (config.services.displayManager.sessionData) desktops;
        # Catppuccin Mocha theme colors
        tuigreetCmd = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --sessions ${desktops}/share/xsessions:${desktops}/share/wayland-sessions \
            --remember \
            --remember-user-session \
            --asterisks \
            --cmd Hyprland \
            --user-menu \
            --greeting "Welcome to NixOS" \
            --window-padding 2 \
            --container-padding 1 \
            --prompt-padding 1 \
            --theme "border=magenta;text=cyan;prompt=green;time=blue;action=yellow;button=magenta;container=black;input=white"
        '';
      in tuigreetCmd;
      user = "greeter";
    };
  };

  # Configure systemd service for greetd
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Set up environment for Wayland sessions
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  # Ensure XDG session directories exist
  environment.pathsToLink = [ 
    "/share/xsessions"
    "/share/wayland-sessions" 
  ];
}