#!/bin/bash

# Setup symlinks to keep configurations in sync with this repository
# This allows you to edit files in the repo and have them automatically
# reflected in the system configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔗 Setting up configuration symlinks..."

# Backup existing files
echo "💾 Backing up existing configuration files..."
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
cp ~/.config/home-manager/home.nix ~/.config/home-manager/home.nix.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# Create symlinks
echo "🔗 Creating symlinks..."

# NixOS configuration
sudo ln -sf "$SCRIPT_DIR/configuration.nix" /etc/nixos/configuration.nix

# Home Manager configuration  
mkdir -p ~/.config/home-manager
ln -sf "$SCRIPT_DIR/home.nix" ~/.config/home-manager/home.nix

echo "✅ Symlinks created successfully!"
echo ""
echo "📝 Now you can:"
echo "1. Edit files directly in: $SCRIPT_DIR"
echo "2. Changes will be automatically reflected in system"
echo "3. Use 'git add/commit/push' to sync to GitHub"
echo ""
echo "🚀 To apply changes:"
echo "   sudo nixos-rebuild switch"
echo "   home-manager switch"
