{ config, pkgs, lib, ... }:

{
  # Kanshi - dynamic display configuration for Wayland
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    
    settings = [
      # Profile when laptop lid is open with external monitor
      {
        profile.name = "docked-open";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "*";
            status = "enable";
            position = "1920,0";
          }
        ];
      }
      
      # Profile when laptop lid is closed with external monitor
      {
        profile.name = "docked-closed";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "*";
            status = "enable";
            position = "0,0";
            mode = "preferred";
            scale = 1.0;
          }
        ];
      }
      
      # Profile for laptop only (undocked)
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            mode = "preferred";
            scale = 1.0;
          }
        ];
      }
    ];
  };

  # Script to detect lid state and switch displays
  home.packages = with pkgs; [
    (writeScriptBin "handle-lid" ''
      #!/bin/sh
      LID_STATE=$(cat /proc/acpi/button/lid/LID0/state 2>/dev/null | awk '{print $2}')
      EXTERNAL_CONNECTED=$(wlr-randr | grep -v "eDP-1" | grep "Enabled: yes" | wc -l)
      
      if [ "$LID_STATE" = "closed" ] && [ "$EXTERNAL_CONNECTED" -gt 0 ]; then
        # Lid closed with external monitor - make external primary
        kanshictl switch docked-closed
        # Move workspace 1 to external monitor
        hyprctl dispatch moveworkspacetomonitor 1 DP-1
      elif [ "$LID_STATE" = "open" ] && [ "$EXTERNAL_CONNECTED" -gt 0 ]; then
        # Lid open with external monitor
        kanshictl switch docked-open
      else
        # Laptop only
        kanshictl switch undocked
      fi
    '')
  ];

  # Hyprland configuration for lid events
  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    # Monitor configuration
    # You may need to adjust these monitor names based on your hardware
    # Use 'wlr-randr' command to find your monitor names
    
    # Bind lid events
    bindl = , switch:on:Lid Switch, exec, handle-lid
    bindl = , switch:off:Lid Switch, exec, handle-lid
    
    # Workspace rules to ensure workspace 1 stays on external when lid is closed
    workspace = 1, monitor:DP-1, default:true
    workspace = 1, monitor:HDMI-A-1, default:true
    
    # Fallback workspace rules
    workspace = 2, monitor:eDP-1
    workspace = 3, monitor:eDP-1
  '';
}