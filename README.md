# NixOS Hyprland Configuration Backup

This repository contains the configuration files for setting up Hyprland on NixOS with Home Manager.

## Files Included

- `configuration.nix` - Main NixOS system configuration
- `home.nix` - Home Manager configuration with Hyprland setup
- `home.nix.original` - Original Home Manager configuration (backup)
- `wallpaper.jpg` - Default wallpaper for Hyprland

## Key Changes Made

### NixOS Configuration (`/etc/nixos/configuration.nix`)
- Disabled X11 server (`services.xserver.enable = false`)
- Enabled Hyprland (`programs.hyprland.enable = true`)
- Added XWayland support
- Configured xdg-desktop-portal for screen sharing
- Added essential fonts (nerd-fonts.droid-sans-mono)
- Enabled Polkit for Hyprland
- Disabled GNOME (commented out)

### Home Manager Configuration (`~/.config/home-manager/home.nix`)
- Added `nixpkgs.config.allowUnfree = true` for Cursor editor
- Added essential Hyprland packages:
  - waybar (status bar)
  - hyprpaper (wallpaper manager)
  - rofi-wayland (application launcher)
  - grim, slurp (screenshot tools)
  - wf-recorder (screen recording)
- Configured Hyprland with complete keybindings:
  - Super+Q: Open Kitty terminal
  - Super+C: Close active window
  - Super+M: Exit Hyprland
  - Super+R: Open Rofi launcher
  - Super+1-0: Switch workspaces
  - Super+Shift+1-0: Move window to workspace
  - Super+S: Take screenshot
  - Arrow keys: Move focus between windows
- Added wallpaper configuration
- Enabled Wayland environment variables for Electron apps

## Hyprland Keybindings

| Key Combination | Action |
|----------------|--------|
| Super+Q | Open Kitty terminal |
| Super+C | Close active window |
| Super+M | Exit Hyprland |
| Super+E | Open file manager (dolphin) |
| Super+V | Toggle floating window |
| Super+R | Open Rofi application launcher |
| Super+P | Toggle pseudo-tiling |
| Super+J | Toggle split direction |
| Super+Arrow Keys | Move focus between windows |
| Super+1-0 | Switch to workspace 1-10 |
| Super+Shift+1-0 | Move window to workspace 1-10 |
| Super+S | Take screenshot (selected area) |
| Super+Shift+S | Take full screenshot |

## Installation Steps

1. Copy `configuration.nix` to `/etc/nixos/`
2. Copy `home.nix` to `~/.config/home-manager/`
3. Run `sudo nixos-rebuild switch`
4. Run `home-manager switch`
5. Reboot and select Hyprland from the login screen

## Recovery Instructions

If Hyprland doesn't work and you need to revert:

1. Boot from a previous NixOS generation (select at boot menu)
2. Copy the original `home.nix.original` back to `~/.config/home-manager/home.nix`
3. Run `home-manager switch` to revert Home Manager changes
4. Edit `/etc/nixos/configuration.nix` to re-enable GNOME if needed
5. Run `sudo nixos-rebuild switch`

## Troubleshooting

- If keybindings don't work, check that Home Manager was applied: `home-manager switch`
- If applications don't start, verify packages are installed: `nix-env -q`
- If screen sharing doesn't work, check xdg-desktop-portal is running
- For Wayland issues, check environment variables: `echo $WAYLAND_DISPLAY`

## Session Progress

This configuration was created during a troubleshooting session where:
1. Initial Hyprland setup had missing keybindings
2. Home Manager configuration was incomplete
3. Essential packages were missing
4. Unfree package policy needed adjustment

All issues have been resolved in this configuration.
