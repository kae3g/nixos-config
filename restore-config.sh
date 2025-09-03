#!/bin/bash

# NixOS Hyprland Configuration Restore Script
# This script restores the Hyprland configuration from this backup

set -e

echo "🔄 Restoring NixOS Hyprland Configuration..."

# Check if running as root for system files
if [[ $EUID -eq 0 ]]; then
    echo "❌ Please run this script as a regular user, not as root"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Backup directory: $SCRIPT_DIR"

# Backup current configurations
echo "💾 Creating backups of current configurations..."
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
cp ~/.config/home-manager/home.nix ~/.config/home-manager/home.nix.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# Restore NixOS configuration
echo "🔧 Restoring NixOS configuration..."
sudo cp "$SCRIPT_DIR/configuration.nix" /etc/nixos/

# Restore Home Manager configuration
echo "🏠 Restoring Home Manager configuration..."
mkdir -p ~/.config/home-manager
cp "$SCRIPT_DIR/home.nix" ~/.config/home-manager/

# Download wallpaper if not present
if [ ! -f ~/Pictures/wallpaper.jpg ]; then
    echo "🖼️  Downloading wallpaper..."
    mkdir -p ~/Pictures
    curl -o ~/Pictures/wallpaper.jpg "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&h=1080&fit=crop&crop=center" || echo "⚠️  Failed to download wallpaper"
fi

echo "✅ Configuration files restored!"
echo ""
echo "🚀 Next steps:"
echo "1. Run: sudo nixos-rebuild switch"
echo "2. Run: home-manager switch"
echo "3. Reboot and select Hyprland"
echo ""
echo "�� Key Hyprland shortcuts:"
echo "   Super+Q: Open terminal"
echo "   Super+R: Open app launcher"
echo "   Super+C: Close window"
echo "   Super+M: Exit Hyprland"
