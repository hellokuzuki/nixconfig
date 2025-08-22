# Adapted from template waybar configuration for Hyprland
{ config, pkgs, lib, ... }:

let
  # Define colors (you can customize these or integrate with stylix later)
  colors = {
    base00 = "1e1e2e"; # Base background (no # prefix)
    base01 = "313244"; # Lighter background
    base04 = "585b70"; # Comments
    base05 = "cdd6f4"; # Default foreground
    base06 = "f5e0dc"; # Light foreground
    base07 = "b4befe"; # Light background
    base08 = "f38ba8"; # Red
    base0A = "f9e2af"; # Yellow
    base0B = "a6e3a1"; # Green
    base0D = "89b4fa"; # Blue
    base0E = "cba6f7"; # Magenta
    base0F = "f5c2e7"; # Orange
  };

  moduleConfiguration = ''
    "hyprland/workspaces": {
      "format": "{icon}",
      "format-icons": {
        "1": "1",
        "2": "2",
        "3": "3",
        "4": "4",
        "5": "5",
        "6": "6",
        "7": "7",
        "8": "8",
        "9": "9",
        "10": "10",
        "active": "",
        "default": ""
      },
      "persistent-workspaces": {
        "*": 5
      }
    },
    "hyprland/window": {
      "format": "{}",
      "separate-outputs": true,
      "max-length": 50
    },
    "memory": {
      "interval": 30,
      "format": "<span foreground='#${colors.base0E}'>󰍛</span>  {used:0.1f}G/{total:0.1f}G",
      "on-click": "kitty --class=htop,htop -e htop"
    },
    "backlight": {
      "device": "intel_backlight",
      "on-scroll-up": "brightnessctl set +1%",
      "on-scroll-down": "brightnessctl set 1%-",
      "format": "<span size='13000' foreground='#${colors.base0D}'>{icon} </span>  {percent}%",
      "format-icons": ["󰃞", "󰃟", "󰃠"]
    },
    "tray": {
      "icon-size": 16,
      "spacing": 10
    },
    "clock": {
      "format": "<span foreground='#${colors.base0E}'> </span>  {:%a %d %H:%M}",
      "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
      "on-click": "gnome-calendar"
    },
    "battery": {
      "states": {
        "warning": 30,
        "critical": 15
      },
      "format": "<span size='13000' foreground='#${colors.base0E}'>{icon}  </span>{capacity}%",
      "format-warning": "<span size='13000' foreground='#${colors.base0E}'>{icon}  </span>{capacity}%",
      "format-critical": "<span size='13000' foreground='#${colors.base08}'>{icon}  </span>{capacity}%",
      "format-charging": "<span size='13000' foreground='#${colors.base0E}'>  </span>{capacity}%",
      "format-plugged": "<span size='13000' foreground='#${colors.base0E}'>  </span>{capacity}%",
      "format-alt": "<span size='13000' foreground='#${colors.base0E}'>{icon} </span>{time}",
      "format-full": "<span size='13000' foreground='#${colors.base0E}'>  </span>{capacity}%",
      "format-icons": ["", "", "", "", ""],
      "tooltip-format": "{time}",
      "interval": 5
    },
    "network": {
      "format-wifi": "<span size='13000' foreground='#${colors.base06}'>󰖩  </span>{essid}",
      "format-ethernet": "<span size='13000' foreground='#${colors.base06}'>󰤭</span> Connected",
      "format-linked": "{ifname} (No IP) 󱚵",
      "format-disconnected": "<span size='13000' foreground='#${colors.base06}'> </span>Disconnected",
      "tooltip-format-wifi": "Signal Strength: {signalStrength}%",
      "on-click": "kitty --class nmtui,nmtui --title=nmtui -o remember_window_size=no -o initial_window_width=400 -o initial_window_height=400 -e nmtui"
    },
    "pulseaudio": {
      "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
      "on-scroll-up": "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+",
      "on-scroll-down": "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-",
      "format": "<span size='13000' foreground='#${colors.base0A}'>{icon}  </span>{volume}%",
      "format-muted": "<span size='13000' foreground='#${colors.base0A}'>  </span>Muted",
      "format-icons": {
        "headphone": "󱡏",
        "hands-free": "",
        "headset": "󱡏",
        "phone": "",
        "portable": "",
        "car": "",
        "default": ["󰕿", "󰖀", "󰕾", "󰕾"]
      }
    },
    "cpu": {
      "format": "<span foreground='#${colors.base0B}'></span> {usage}%",
      "tooltip": true,
      "interval": 5
    }
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;  # Disabled because Hyprland starts waybar via exec-once
      target = "hyprland-session.target";
    };
  };

  # Use home.file to create config files for more control over formatting
  home.file = {
    ".config/waybar/config.jsonc".text = ''
      {
        "position": "top",
        "layer": "top",
        "height": 35,
        "modules-left": [
          "hyprland/workspaces",
          "tray",
          "hyprland/window"
        ],
        "modules-center": [
          "clock"
        ],
        "modules-right": [
          "cpu",
          "memory",
          "network",
          "pulseaudio",
          "backlight",
          "battery"
        ],
        ${moduleConfiguration}
      }
    '';

    ".config/waybar/style.css".text = ''
      @keyframes gradient_f {
        0% {
          background-position: 0% 200%;
        }
        50% {
          background-position: 200% 0%;
        }
        100% {
          background-position: 400% 200%;
        }
      }

      @keyframes gradient_f_nh {
        0% {
          background-position: 0% 200%;
        }
        100% {
          background-position: 200% 200%;
        }
      }

      @keyframes gradient_rv {
        0% {
          background-position: 200% 200%;
        }
        100% {
          background-position: 0% 200%;
        }
      }

      * {
        font-size: 14px;
        font-family: "Hug Me Tight", "Xiaolai SC";
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      tooltip {
        background: #${colors.base01};
        border-radius: 5px;
        border-width: 2px;
        border-style: solid;
        border-color: #${colors.base07};
      }

      #network,
      #clock,
      #battery,
      #pulseaudio,
      #workspaces,
      #backlight,
      #memory,
      #cpu,
      #tray,
      #window {
        padding: 4px 10px;
        background: rgba(30, 30, 46, 0.9);
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.377);
        color: #${colors.base05};
        margin-top: 10px;
        margin-bottom: 5px;
        margin-left: 5px;
        margin-right: 5px;
        box-shadow: 1px 2px 2px #101010;
        border-radius: 10px;
      }

      #workspaces {
        margin-left: 15px;
        font-size: 0px;
        padding: 6px 3px;
        border-radius: 20px;
      }

      #workspaces button {
        font-size: 0px;
        background-color: #${colors.base07};
        padding: 0px 1px;
        margin: 0px 4px;
        border-radius: 20px;
        transition: all 0.25s cubic-bezier(0.55, -0.68, 0.48, 1.682);
        border: none;
        color: transparent;
      }

      #workspaces button.active {
        font-size: 1px;
        background-color: #${colors.base0E};
        border-radius: 20px;
        min-width: 30px;
        background-size: 400% 400%;
      }

      #workspaces button.empty {
        font-size: 1px;
        background-color: #${colors.base04};
      }

      #workspaces button:hover {
        background: rgba(148, 226, 213, 0.2);
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #window {
        color: #${colors.base00};
        background: linear-gradient(90deg, #${colors.base05} 0%, #${colors.base07} 100%);
        background-size: 400% 400%;
        animation: gradient_f 40s ease-in-out infinite;
        transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
      }

      window#waybar.empty #window {
        background: none;
        background-color: transparent;
        box-shadow: none;
      }

      #battery {
        margin-right: 15px;
        background: linear-gradient(
          118deg,
          #${colors.base0B} 5%,
          #${colors.base0F} 5%,
          #${colors.base0F} 20%,
          #${colors.base0B} 20%,
          #${colors.base0B} 40%,
          #${colors.base0F} 40%,
          #${colors.base0F} 60%,
          #${colors.base0B} 60%,
          #${colors.base0B} 80%,
          #${colors.base0F} 80%,
          #${colors.base0F} 95%,
          #${colors.base0B} 95%
        );
        background-size: 200% 300%;
        animation: gradient_f_nh 4s linear infinite;
        color: #${colors.base01};
      }

      #battery.charging,
      #battery.plugged {
        background: linear-gradient(
          118deg,
          #${colors.base0E} 5%,
          #${colors.base0D} 5%,
          #${colors.base0D} 20%,
          #${colors.base0E} 20%,
          #${colors.base0E} 40%,
          #${colors.base0D} 40%,
          #${colors.base0D} 60%,
          #${colors.base0E} 60%,
          #${colors.base0E} 80%,
          #${colors.base0D} 80%,
          #${colors.base0D} 95%,
          #${colors.base0E} 95%
        );
        background-size: 200% 300%;
        animation: gradient_rv 4s linear infinite;
      }

      #battery.full {
        background: linear-gradient(
          118deg,
          #${colors.base0E} 5%,
          #${colors.base0D} 5%,
          #${colors.base0D} 20%,
          #${colors.base0E} 20%,
          #${colors.base0E} 40%,
          #${colors.base0D} 40%,
          #${colors.base0D} 60%,
          #${colors.base0E} 60%,
          #${colors.base0E} 80%,
          #${colors.base0D} 80%,
          #${colors.base0D} 95%,
          #${colors.base0E} 95%
        );
        background-size: 200% 300%;
        animation: gradient_rv 20s linear infinite;
      }

      #battery.critical:not(.charging) {
        background: #${colors.base08};
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: #${colors.base08};
          color: #${colors.base00};
        }
      }

      #tray {
        background: rgba(30, 30, 46, 0.9);
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #clock {
        font-weight: bold;
      }

      #cpu {
        color: #${colors.base05};
      }

      #memory {
        color: #${colors.base05};
      }

      #network {
        color: #${colors.base05};
      }

      #network.disconnected {
        color: #${colors.base08};
      }

      #pulseaudio {
        color: #${colors.base05};
      }

      #pulseaudio.muted {
        color: #${colors.base04};
      }
    '';
  };
}