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
