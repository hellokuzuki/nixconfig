# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS and Home Manager configuration using Nix flakes. The configuration manages both system-level (NixOS) and user-level (Home Manager) settings for a user named "mark" on a system called "nixos".

## Commands

### System Configuration (NixOS)
```bash
# Rebuild and switch to new NixOS configuration
sudo nixos-rebuild switch --flake .#nixos

# Test configuration without switching
sudo nixos-rebuild test --flake .#nixos

# Build configuration without switching
sudo nixos-rebuild build --flake .#nixos
```

### Home Manager Configuration
```bash
# Apply home-manager configuration
home-manager switch --flake .#mark@nixos

# Build home-manager configuration without switching
home-manager build --flake .#mark@nixos
```

### Nix Flake Commands
```bash
# Update flake inputs
nix flake update

# Show flake metadata
nix flake show

# Format nix files
nix fmt
```

## Architecture

### Flake Structure
- **flake.nix**: Main entry point defining inputs (nixpkgs, home-manager, claude-code) and outputs
- Uses nixpkgs 25.05 stable with unstable overlay available
- Supports multiple systems (x86_64-linux, aarch64-linux, darwin variants)

### Directory Layout
- **nixos/**: System-level NixOS configuration
  - `configuration.nix`: Main system config (GNOME, networking, users, system packages)
  - `hardware-configuration.nix`: Hardware-specific settings
  
- **home-manager/**: User-level configuration
  - `home.nix`: Main home config importing all modules
  - `packages.nix`: User packages (ripgrep, fzf, eza, etc.)
  - `fonts.nix`: Font configuration
  - `programs/`: Modular program configurations
    - `browsers/`: Chrome browser setup
    - `coding/`: VSCode configuration
    - `shell/`: Fish shell and Starship prompt
    - `terminals/`: Kitty terminal config

- **modules/**: Reusable NixOS and home-manager modules
- **overlays/**: Custom package overlays including unstable packages
- **pkgs/**: Custom package definitions

### Key Configuration Details
- User "mark" uses Fish shell as default
- Chinese input method (fcitx5) configured with Rime and pinyin
- GNOME desktop environment with Wayland
- System packages include development tools (git, vim, JDK21, AWS CLI, MySQL Workbench, Postman)
- Home packages focus on modern CLI tools (ripgrep, zoxide, fzf, eza, fd)

### Modifying Configuration
When adding new programs or system packages:
1. System packages go in `nixos/configuration.nix` under `environment.systemPackages`
2. User packages go in `home-manager/packages.nix` under `home.packages`
3. Program-specific configs should be created as new modules under `home-manager/programs/`
4. After changes, use the rebuild commands above to apply them