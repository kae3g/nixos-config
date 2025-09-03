# NixOS Hyprland Configuration

This repository contains a complete NixOS configuration with Hyprland window manager, optimized for productivity and eye comfort.

> **⚠️ Important Note for Users**: If you're using this repository as a reference for your own personal NixOS configuration, you may need to manually update or ask your Cursor editor to change the Git configuration and `~ /home/user` directory references to match your own personal information and system setup.

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
- `scripts/hyprsunset-toggle.sh` - Blue light filter toggle script

## 🎨 Blue Light Filtering with Hyprsunset

This configuration uses **Hyprsunset** (the official Hyprland utility) for blue light filtering and eye comfort:

### Installation
Hyprsunset is automatically included in the Home Manager configuration via `pkgs.hyprsunset`.

### Usage
```bash
# Enable blue light filter (3000K temperature)
hyprctl hyprsunset temperature 3000

# Disable blue light filter (reset to normal)
hyprctl hyprsunset identity

# Check current status
hyprctl hyprsunset status

# Toggle using our custom script
$HOME/nixos-config-backup/scripts/hyprsunset-toggle.sh
```

### Keybinding
- **Super + Shift + B** - Toggle blue light filter on/off

### Recommended Settings
- **3000K** - Warm evening light (recommended for blue light filtering)
- **Identity** - Normal color temperature (disable filter)

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

### Blue Light Filter
| Key Combination | Action |
|----------------|--------|
| **Super + Shift + B** | Toggle Hyprsunset blue light filter |

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
- **Hyprsunset** for blue light filtering
- **Speedtest-cli** with secure connection alias

### Environment Variables
- **Wayland optimization** for Electron apps
- **Ozone platform** hints for better compatibility
- **XDG desktop** environment variables

## 🛠️ Troubleshooting

### Common Issues

**Keybindings not working:**
```bash
home-manager switch
hyprctl reload
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

**Blue light filter not working:**
```bash
# Check if hyprsunset is running
pgrep hyprsunset

# Start hyprsunset if needed
hyprsunset &

# Test the toggle script
$HOME/nixos-config-backup/scripts/hyprsunset-toggle.sh
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
- **System**: waybar, rofi-wayland, grim, slurp, hyprsunset
- **Network**: speedtest-cli

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
- Blue light filtering uses Hyprsunset (official Hyprland utility)
- Speedtest automatically uses secure HTTPS connections

## 🤝 Contributing

This is a personal configuration repository. Feel free to use it as a reference for your own NixOS setup.

---

**Last Updated**: September 2025  
**NixOS Version**: 25.05  
**Home Manager**: Compatible with current release

## 📋 Complete Keybindings Reference

### Essential Applications
| Key Combination | Action |
|----------------|--------|
| **Super + Return** | Open Kitty terminal |
| **Super + Q** | Open Kitty terminal (alternative) |
| **Super + B** | Open Brave browser |
| **Super + D** | Open Cursor editor |
| **Super + E** | Open file manager (Nautilus) |
| **Super + R** | Open Rofi application launcher |

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

### Window Focus (Arrow Keys)
| Key Combination | Action |
|----------------|--------|
| **Super + Left** | Move focus left |
| **Super + Right** | Move focus right |
| **Super + Up** | Move focus up |
| **Super + Down** | Move focus down |

### Window Focus (Vim-style)
| Key Combination | Action |
|----------------|--------|
| **Super + H** | Move focus left |
| **Super + L** | Move focus right |
| **Super + K** | Move focus up |
| **Super + J** | Move focus down |

### Screenshots
| Key Combination | Action |
|----------------|--------|
| **Super + S** | Take screenshot (selected area) |
| **Super + Shift + S** | Take full screenshot |

### Blue Light Filter
| Key Combination | Action |
|----------------|--------|
| **Super + Shift + B** | Toggle Hyprsunset blue light filter |

### Emergency Controls
| Key Combination | Action |
|----------------|--------|
| **Super + M** | Exit Hyprland (logout) |
| **Ctrl + Alt + F2** | Switch to TTY (when frozen) |
| **Ctrl + Alt + F1** | Return to Hyprland |

### Mouse Controls
| Key Combination | Action |
|----------------|--------|
| **Super + Left Mouse** | Move window |
| **Super + Right Mouse** | Resize window |

### Available Unused Keys
The following keys are currently unused and available for future keybindings:
- **Super + A, G, I, N, O, T, U, W, X, Y, Z**

