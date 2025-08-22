{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Performance and debugging options
      debug = {
        disable_logs = true;  # Disable logging for performance
        disable_time = true;
      };
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -show drun";

      monitor = [
        # Built-in laptop display with preferred resolution and 2.5x scaling
        "eDP-1,preferred,auto,2.5"
        # External monitors - will automatically configure when connected
        ",preferred,auto,1"
      ];

      exec-once = [
        "waybar"
        "swww init"
        "dunst"
        "nm-applet"
        "blueman-applet"
        "fcitx5 -d"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # Catppuccin Macchiato colors
        "col.active_border" = "rgba(c6a0f6ee) rgba(f5bde6ee) 45deg";  # Purple to Pink gradient
        "col.inactive_border" = "rgba(5b6078aa)";  # Surface2
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = false;  # Disable blur to reduce GPU load
          size = 3;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 3, myBezier"  # Faster window animations
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 5, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vfr = true;
        vrr = 1;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
      };

      input = {
        kb_layout = "au";
        kb_variant = "";
        kb_options = "";
        kb_rules = "";
        
        follow_mouse = 1;
        mouse_refocus = false;
        
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap-to-click = true;
        };
        
        sensitivity = 0;
        accel_profile = "flat";
        
        # Reduce input latency
        repeat_rate = 50;
        repeat_delay = 300;
        numlock_by_default = true;
        resolve_binds_by_sym = false;
        float_switch_override_focus = 2;
      };

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, $fileManager"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, F, fullscreen,"
        
        # Suspend system
        "$mod, Escape, exec, systemctl suspend"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move focus with mod + hjkl
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move windows with mod + SHIFT + arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Move windows with mod + SHIFT + hjkl
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # Media keys
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        
        # Power management
        "$mod, B, exec, rofi-power-menu"
        "$mod SHIFT, B, exec, gnome-control-center power"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Lid switch handling for clamshell mode
      bindl = [
        # When lid is closed, turn off laptop display
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
        # When lid is opened, re-enable laptop display with preferred resolution and 2.5x scaling
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1,preferred,auto,2.5\""
      ];
      
      # Window rules for fcitx5
      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(blueberry.py)$"
        "float,class:^(gnome-control-center)$"
        
        # Fcitx5 configuration tool
        "float,class:^(org.fcitx.fcitx5-config-qt)$"
        "center,class:^(org.fcitx.fcitx5-config-qt)$"
        "size 800 600,class:^(org.fcitx.fcitx5-config-qt)$"
        
        # Fcitx5 input popup
        "noanim,class:^(fcitx)$"
        "noborder,class:^(fcitx)$"
        "noshadow,class:^(fcitx)$"
      ];
    };
  };
}