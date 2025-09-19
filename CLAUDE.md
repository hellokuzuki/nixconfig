# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

NixOS and Home Manager configuration using Nix flakes for user "mark" on hostname "nixos". The setup uses nixpkgs 25.05 with fcitx5 for Chinese input and GNOME desktop.

## Commands

### Quick Commands (using nh helper)
```bash
# System rebuild - defined in fish.nix as 'nixu'
nh os switch --ask .

# Home Manager rebuild - defined in fish.nix as 'homeu'  
nh home switch --ask .

# Clean old generations - defined in fish.nix as 'nixc'
sudo -E nh clean all --keep-since 7d --keep 5
```

### Standard Commands
```bash
# NixOS rebuild
sudo nixos-rebuild switch --flake .#nixos

# Home Manager rebuild
home-manager switch --flake .#mark@nixos

# Update all flake inputs
nix flake update

# Format nix files (uses alejandra)
nix fmt
```

## Architecture

### Core Structure
- **flake.nix**: Entry point with inputs (nixpkgs 25.05, nixpkgs-unstable, home-manager, claude-code)
- **nixos/configuration.nix**: System config - GNOME, networking, Docker, development tools
- **home-manager/home.nix**: User config entry importing packages and programs
- **overlays/**: Unstable packages overlay for accessing latest versions

### Key Configurations

**System packages** (nixos/configuration.nix):
- Development: git, vim, JDK21, awscli2, claude-code
- Communication: slack, teams-for-linux  
- Database/API: mysql-workbench, postman
- Virtualization: Docker with btrfs storage driver

**User packages** (home-manager/packages.nix):
- CLI tools: ripgrep, zoxide, fzf, eza, fd, nh
- System info: neofetch, htop

**Programs** (home-manager/programs/):
- Shell: Fish with zoxide, custom abbreviations (nixu, homeu, nixc)
- Editor: Neovim with LSP and Treesitter configured
- VSCode: Defined in vscode.nix
- Terminal: Kitty
- Prompt: Starship

### Important Details
- Fish shell is default for user mark
- Chinese input via fcitx5 with pinyin support
- Docker enabled with rootless mode
- Experimental features: nix-command, flakes