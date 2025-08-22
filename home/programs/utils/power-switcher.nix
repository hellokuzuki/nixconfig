{ config, pkgs, ... }:

let
  power-switcher = pkgs.writeShellScriptBin "power-switcher" ''
    #!/usr/bin/env bash
    
    # Simple power profile switcher
    case "$1" in
      "performance")
        echo "Switching to Performance mode..."
        sudo cpupower frequency-set -g performance
        echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        notify-send "Power Profile" "Switched to Performance mode" -i battery-full-charged
        ;;
      "balanced")
        echo "Switching to Balanced mode..."
        sudo cpupower frequency-set -g ondemand
        echo "ondemand" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        notify-send "Power Profile" "Switched to Balanced mode" -i battery-good
        ;;
      "powersave")
        echo "Switching to Power Save mode..."
        sudo cpupower frequency-set -g powersave
        echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        notify-send "Power Profile" "Switched to Power Save mode" -i battery-low
        ;;
      "status")
        echo "Current CPU Governor:"
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo ""
        echo "CPU Frequencies:"
        grep MHz /proc/cpuinfo | head -4
        echo ""
        echo "TLP Status:"
        sudo tlp-stat -s
        ;;
      *)
        echo "Usage: power-switcher [performance|balanced|powersave|status]"
        echo ""
        echo "Options:"
        echo "  performance - Maximum performance, no power saving"
        echo "  balanced    - Balance between performance and power saving"
        echo "  powersave   - Maximum power saving"
        echo "  status      - Show current power profile status"
        ;;
    esac
  '';
  
  rofi-power-menu = pkgs.writeShellScriptBin "rofi-power-menu" ''
    #!/usr/bin/env bash
    
    # Rofi power profile menu
    chosen=$(echo -e "Performance\nBalanced\nPower Save\nTLP Status\nCPU Status" | rofi -dmenu -p "Power Profile")
    
    case "$chosen" in
      "Performance")
        power-switcher performance
        ;;
      "Balanced")
        power-switcher balanced
        ;;
      "Power Save")
        power-switcher powersave
        ;;
      "TLP Status")
        sudo tlp-stat -s | rofi -dmenu -p "TLP Status"
        ;;
      "CPU Status")
        power-switcher status | rofi -dmenu -p "Power Status"
        ;;
    esac
  '';
in
{
  home.packages = [
    power-switcher
    rofi-power-menu
  ];
  
  # Add desktop entries for easy access
  xdg.desktopEntries = {
    power-switcher = {
      name = "Power Profile Switcher";
      genericName = "Power Management";
      exec = "rofi-power-menu";
      terminal = false;
      categories = [ "System" "Settings" ];
      icon = "battery";
    };
  };
}