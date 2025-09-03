#!/usr/bin/env bash

# NixOS Configuration Backup Script
# This script backs up all configuration files to the nixos-config-backup directory

set -e

BACKUP_DIR="/home/xx/nixos-config-backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

echo "🔄 Backing up NixOS configuration files..."

# Create backup directory structure
mkdir -p "$BACKUP_DIR"/{nixos,home-manager,hyprland,scripts}

# Backup NixOS configuration
echo "📁 Backing up NixOS configuration..."
cp /etc/nixos/configuration.nix "$BACKUP_DIR/nixos/configuration.nix"
cp /etc/nixos/hardware-configuration.nix "$BACKUP_DIR/nixos/hardware-configuration.nix"

# Backup Home Manager configuration
echo "🏠 Backing up Home Manager configuration..."
cp /home/xx/.config/home-manager/home.nix "$BACKUP_DIR/home-manager/home.nix"

# Backup Hyprland configuration (if it exists)
echo "🪟 Backing up Hyprland configuration..."
if [ -d "/home/xx/.config/hypr" ]; then
    cp -r /home/xx/.config/hypr "$BACKUP_DIR/hyprland/"
fi

# Backup Waybar configuration (if it exists)
if [ -d "/home/xx/.config/waybar" ]; then
    cp -r /home/xx/.config/waybar "$BACKUP_DIR/hyprland/"
fi

# Create a restore script
echo "📝 Creating restore script..."
cat > "$BACKUP_DIR/restore-configs.sh" << 'RESTORE_EOF'
#!/bin/bash

# NixOS Configuration Restore Script
# This script restores configuration files from the backup

set -e

BACKUP_DIR="/home/xx/nixos-config-backup"

echo "🔄 Restoring NixOS configuration files..."

# Restore NixOS configuration
echo "📁 Restoring NixOS configuration..."
sudo cp "$BACKUP_DIR/nixos/configuration.nix" /etc/nixos/configuration.nix
sudo cp "$BACKUP_DIR/nixos/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix

# Restore Home Manager configuration
echo "🏠 Restoring Home Manager configuration..."
cp "$BACKUP_DIR/home-manager/home.nix" /home/xx/.config/home-manager/home.nix

# Restore Hyprland configuration
echo "🪟 Restoring Hyprland configuration..."
if [ -d "$BACKUP_DIR/hyprland/hypr" ]; then
    cp -r "$BACKUP_DIR/hyprland/hypr" /home/xx/.config/
fi

if [ -d "$BACKUP_DIR/hyprland/waybar" ]; then
    cp -r "$BACKUP_DIR/hyprland/waybar" /home/xx/.config/
fi

echo "✅ Configuration files restored!"
echo "🔄 Run 'sudo nixos-rebuild switch' and 'home-manager switch' to apply changes"
RESTORE_EOF

chmod +x "$BACKUP_DIR/restore-configs.sh"

# Create a README with instructions
cat > "$BACKUP_DIR/README.md" << 'README_EOF'
# NixOS Configuration Backup

This repository contains backup copies of your NixOS and Home Manager configuration files.

## Files Structure

- `nixos/` - NixOS system configuration files
- `home-manager/` - Home Manager user configuration files  
- `hyprland/` - Hyprland window manager configuration files
- `scripts/` - Backup and restore scripts

## Usage

### Backup Current Configuration
```bash
./backup-configs.sh
```

### Restore Configuration
```bash
./restore-configs.sh
sudo nixos-rebuild switch
home-manager switch
```

### Git Operations
```bash
# Add and commit changes
git add .
git commit -m "Backup configuration $(date)"

# Push to GitHub (if remote is set up)
git push origin main
```

## Important Notes

- Always backup before making changes
- Test configurations in a VM if possible
- Keep this repository in sync with your actual configuration files
- The restore script requires sudo privileges for NixOS files

## Recovery from Previous NixOS Build

If you need to revert to a previous NixOS build:

1. Boot into the previous build from GRUB
2. Run `./restore-configs.sh` to restore configuration files
3. Run `sudo nixos-rebuild switch` and `home-manager switch`
4. Reboot into the new configuration

## Hyprland Keybindings

The current configuration includes these keybindings:
- `Super + Q` - Open Kitty terminal
- `Super + C` - Close active window
- `Super + M` - Exit Hyprland
- `Super + R` - Open Rofi launcher
- `Super + V` - Toggle floating window
- `Super + 1-9` - Switch workspaces
- `Super + Shift + 1-9` - Move window to workspace
- `Super + S` - Screenshot (select area)
- `Super + Shift + S` - Screenshot (full screen)
README_EOF

echo "✅ Backup completed successfully!"
echo "📁 Files backed up to: $BACKUP_DIR"
echo "📝 Run './restore-configs.sh' to restore configuration files"
echo "🔄 Run 'git add . && git commit -m \"Backup $(date)\"' to save to Git"
