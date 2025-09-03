# NixOS Hyprland Configuration

This repository contains a complete NixOS configuration with Hyprland window manager, optimized for productivity and eye comfort.

## 🚀 Quick Start

1. Copy `configuration.nix` to `/etc/nixos/`
2. Copy `home.nix` to `~/.config/home-manager/`
3. Run `sudo nixos-rebuild switch`
4. Run `home-manager switch`
5. Reboot and select Hyprland from the login screen

## 📁 Repository Structure

- `configuration.nix` - Main NixOS system configuration
- `home.nix` - Home Manager configuration with Hyprland setup
- `home.nix.original` - Original Home Manager configuration (backup)
- `wallpaper.jpg` - Default wallpaper for Hyprland
- `scripts/` - Utility scripts for backup and restore

## 🎨 Blue Light Filtering with Hyprshade

This configuration uses **Hyprshade** for blue light filtering and eye comfort:

### Installation
```bash
# Hyprshade is not included in the config - install manually if needed
nix-env -iA nixpkgs.hyprshade
```

### Usage
```bash
# Enable blue light filter (night mode)
hyprshade on blue-light-filter

# Disable blue light filter
hyprshade off

# List available shaders
hyprshade list

# Set custom temperature (2000K-6500K)
hyprshade on blue-light-filter:2000
```

### Recommended Shaders
- `blue-light-filter` - Standard blue light reduction
- `blue-light-filter:2000` - Very warm (night time)
- `blue-light-filter:3000` - Warm (evening)
- `blue-light-filter:4000` - Moderate (day time)

## 🆘 Emergency Hyprland Controls

### Session Management
| Key Combination | Action | Use Case |
|----------------|--------|----------|
| **Super + M** | Exit Hyprland | Complete session logout |
| **Super + Shift + Q** | Kill active window | Force close unresponsive app |
| **Super + C** | Kill active window | Alternative window killer |

### System Recovery
| Key Combination | Action | Use Case |
|----------------|--------|----------|
| **Ctrl + Alt + F2** | Switch to TTY | When Hyprland is completely frozen |
| **Ctrl + Alt + F1** | Return to Hyprland | After TTY recovery |

### TTY Recovery Commands
If Hyprland becomes unresponsive:
```bash
# Switch to TTY (Ctrl + Alt + F2)
# Kill Hyprland process
pkill Hyprland

# Restart Hyprland
Hyprland

# Or restart the entire session
systemctl restart display-manager
```

## ⌨️ Complete Keybindings Reference

### Essential Navigation
| Key Combination | Action |
|----------------|--------|
| **Super + Return** | Open Kitty terminal |
| **Super + Q** | Open Kitty terminal (alternative) |
| **Super + R** | Open Rofi application launcher |
| **Super + E** | Open file manager (Nautilus) |
| **Super + B** | Open Brave browser |
| **Super + D** | Open Cursor editor |

### Window Management
| Key Combination | Action |
|----------------|--------|
| **Super + C** | Close active window |
| **Super + Shift + Q** | Kill active window (force close) |
| **Super + V** | Toggle floating window |
| **Super + P** | Toggle pseudo-tiling |
| **Super + J** | Toggle split direction |
| **Super + F** | Toggle fullscreen |
| **Super + Shift + F** | Exit fullscreen |

### Workspace Navigation
| Key Combination | Action |
|----------------|--------|
| **Super + 1-0** | Switch to workspace 1-10 |
| **Super + Shift + 1-0** | Move window to workspace 1-10 |
| **Super + Mouse Wheel** | Switch workspaces |

### Window Focus
| Key Combination | Action |
|----------------|--------|
| **Super + Arrow Keys** | Move focus between windows |
| **Super + H/J/K/L** | Move focus (vim-style) |

### Screenshots
| Key Combination | Action |
|----------------|--------|
| **Super + S** | Take screenshot (selected area) |
| **Super + Shift + S** | Take full screenshot |

### Mouse Controls
| Key Combination | Action |
|----------------|--------|
| **Super + Left Mouse** | Move window |
| **Super + Right Mouse** | Resize window |

## 🔧 Configuration Features

### System Configuration
- **Wayland-only** (X11 disabled for better performance)
- **AMD GPU** support with amdgpu driver
- **PipeWire** audio system
- **NetworkManager** for networking
- **Docker** virtualization support
- **Auto-upgrades** enabled

### Home Manager Features
- **GPG signing** configured for git commits
- **SSH key management** with gnome-keyring
- **Cursor editor** with Wayland support
- **Brave browser** with Wayland optimization
- **Complete Hyprland** setup with waybar
- **Essential packages** for development and productivity

### Environment Variables
- **Wayland optimization** for Electron apps
- **Ozone platform** hints for better compatibility
- **XDG desktop** environment variables

## 🛠️ Troubleshooting

### Common Issues

**Keybindings not working:**
```bash
home-manager switch
```

**Applications not starting:**
```bash
# Check if packages are installed
nix-env -q

# Rebuild if needed
nixos-rebuild switch
```

**Screen sharing not working:**
```bash
# Check xdg-desktop-portal
systemctl --user status xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-hyprland
```

**Wayland issues:**
```bash
# Check environment variables
echo $WAYLAND_DISPLAY
echo $XDG_SESSION_TYPE
```

### Recovery Instructions

**If Hyprland doesn't work:**
1. Boot from previous NixOS generation (select at boot menu)
2. Copy `home.nix.original` back to `~/.config/home-manager/home.nix`
3. Run `home-manager switch` to revert
4. Edit `/etc/nixos/configuration.nix` to re-enable GNOME if needed
5. Run `sudo nixos-rebuild switch`

**If system is completely broken:**
1. Boot from USB/NixOS installer
2. Mount your system
3. Restore from git repository
4. Rebuild configuration

## 📦 Package Management

### Essential Packages Included
- **Development**: git, nodejs, python3, docker
- **Editors**: cursor, neovim, emacs, kakoune
- **Terminals**: kitty, oterm
- **Browsers**: brave
- **Communication**: discord, signal-desktop
- **Media**: spotify
- **System**: waybar, rofi-wayland, grim, slurp

### Adding New Packages
Edit `home.nix` and add to `home.packages`:
```nix
home.packages = [
  pkgs.your-package-name
];
```

Then run:
```bash
home-manager switch
```

## 🔐 Security Features

- **GPG commit signing** enabled
- **SSH key management** with gnome-keyring
- **Firewall** configurable
- **Polkit** for privilege escalation

## 📝 Notes

- This configuration was created and tested on NixOS 25.05
- All configurations are declarative and reproducible
- GPG signing works in both terminal and Cursor editor
- SSH authentication is configured for GitHub
- Repository is kept clean with no obsolete files

## 🤝 Contributing

This is a personal configuration repository. Feel free to use it as a reference for your own NixOS setup.

---

**Last Updated**: September 2025  
**NixOS Version**: 25.05  
**Home Manager**: Compatible with current release
