# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is a NixOS system configuration using Nix flakes with Home Manager integration. The configuration manages both system-level and user-specific packages for a NixOS installation.

## Architecture

### Directory Structure
```
.
├── flake.nix                 # Entry point, defines system configurations
├── hosts/                    # Machine-specific configurations
│   └── nixos/               # Default host configuration
│       ├── default.nix      # Main host configuration
│       └── hardware-configuration.nix
├── home/                     # Home-manager configuration for user mark
│   ├── default.nix          # Main home configuration
│   ├── packages.nix         # User packages
│   └── programs.nix         # User program configurations
├── modules/                  # Reusable configuration modules
│   └── system/              # System-wide modules
│       ├── boot.nix        # Bootloader configuration
│       ├── desktop.nix     # Desktop environment (GNOME)
│       ├── locale.nix      # Timezone and localization
│       ├── networking.nix  # Network and SSH configuration
│       ├── packages.nix    # System packages
│       └── users.nix       # User accounts
├── overlays/                # Custom package overlays (empty)
└── lib/                     # Helper functions (empty)
```

### Key Design Principles
- **Modular**: System configuration split into focused modules for easier maintenance
- **Host-based**: Machine-specific settings isolated in hosts/ directory
- **Clean separation**: System modules in modules/system/, user config in home/

## Common Commands

### Building and Switching Configuration (with NH)
```bash
# Using NH (Nix Helper) - recommended
nh os switch              # Build and switch NixOS configuration
nh os switch --ask        # Build and switch with confirmation
nh home switch            # Build and switch home-manager configuration

# Traditional commands
sudo nixos-rebuild switch --flake .#nixos
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
```

### Fish Shell Abbreviations
```bash
nixu    # Expands to: nh os switch --ask
homeu   # Expands to: nh home switch --ask
nixc    # Expands to: nh clean all --keep-since 7d --keep 5
cd      # Expands to: z (using zoxide)
```

### Cleaning Old Generations
```bash
# Clean all old generations (keeps last 7 days or 5 generations)
nh clean all

# Clean with custom parameters
nh clean all --keep-since 3d --keep 3

# Dry run to see what would be deleted
nh clean all --dry

# Clean only user or system profiles
nh clean user
nh clean profile
```

### Updating Dependencies
```bash
# Update flake lock file
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### Checking Configuration
```bash
# Check flake for errors
nix flake check

# Show flake info
nix flake show
```

## Configuration Notes

- System timezone: Australia/Melbourne
- Desktop environment: GNOME with GDM
- Currently tracking nixpkgs-unstable branch
- Home Manager is integrated as a NixOS module
- Experimental features enabled: nix-command, flakes


  1. Replaced GNOME with Hyprland in /home/mark/flakes/modules/system/desktop.nix:11-13 - Switched from GDM/GNOME to SDDM/Hyprland with
   Wayland support
  2. Added essential Hyprland packages in /home/mark/flakes/modules/system/packages.nix:24-40:
    - Window manager utilities: waybar, rofi-wayland, dunst, swww
    - Terminal: kitty
    - Clipboard/screenshot tools: wl-clipboard, grim, slurp
    - Lock screen: swaylock-effects, swayidle
    - System controls: brightnessctl, pamixer, playerctl
    - System tray apps: networkmanagerapplet, blueman, pavucontrol
  3. Created Hyprland user configuration in /home/mark/flakes/home/programs/desktop/hyprland.nix with:
    - Super key as modifier
    - Modern animations and blur effects
    - Workspace management (1-10)
    - Common keybindings for terminal, file manager, app launcher
    - Media key support
    - Screenshot functionality
  4. Configured Waybar in /home/mark/flakes/home/programs/desktop/waybar.nix with workspaces, clock, system stats, and tray

  The configuration passes nix flake check. To apply these changes, run:
  nh os switch --ask

  After rebooting, you'll be greeted by SDDM and can log into Hyprland. The default keybindings include:
  - Super+Return: Open terminal (kitty)
  - Super+R: App launcher (rofi)
  - Super+Q: Close window
  - Super+1-9: Switch workspaces
  - Print: Screenshot selection