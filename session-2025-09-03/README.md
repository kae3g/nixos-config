# NixOS Configuration Session - September 3, 2025

## Overview
This session focused on improving Hyprland stability, implementing a working blue light filter, and adding internet speed testing capabilities.

## Key Changes Made

### 1. Hyprland Stability Improvements
- **File**: `home-manager/home.nix`
- **Changes**: 
  - Added systemd environment imports to `exec-once`
  - Added Brave browser window rules (float, 80% size)
  - Added emergency keybindings for Hyprland recovery
  - Added timeout configurations

### 2. Blue Light Filter Implementation
- **Files**: 
  - `home-manager/home.nix` - Package installation and keybindings
  - `hyprland/blue-light-filter.frag` - GLSL shader for blue light filtering
- **Solution**: Used `hyprshade` with custom GLSL shader instead of problematic Wayland gamma tools
- **Keybindings**:
  - `Super + B` - Turn on blue light filter
  - `Super + Shift + B` - Turn off blue light filter
- **Auto-application**: Blue light filter automatically applies in new terminal sessions

### 3. Package Additions
- **speedtest-cli** - Command-line internet speed testing
- **hyprshade** - Hyprland-native blue light filter using screen shaders

### 4. Failed Attempts (Documented for Reference)
- `gammastep` - Incompatible with Wayland
- `wlsunset` - Command not found issues
- `wl-gammarelay-rs` - Complex server setup required
- `wl-gammactl` - Failed to set gamma table
- `redshift` - X11-only, no Wayland support

## File Structure
```
session-2025-09-03/
├── home-manager/
│   └── home.nix                    # Main Home Manager configuration
├── hyprland/
│   └── blue-light-filter.frag      # GLSL shader for blue light filtering
├── backups/
│   ├── home.nix.backup             # Various backup versions
│   ├── home.nix.backup2
│   ├── home.nix.backup3
│   └── home.nix.backup.20250902_203545
└── README.md                       # This file
```

## Key Features Implemented

### Hyprland Configuration
- **Stability**: Added systemd environment imports and recovery keybindings
- **Window Management**: Brave browser floating window rules
- **Emergency Controls**: 
  - `Super + Shift + Escape` - Kill Hyprland
  - `Super + Ctrl + R` - Reload Hyprland
  - `Super + Alt + R` - Kill Brave browser
  - `Super + Shift + R` - Restart Hyprland session

### Blue Light Filter
- **Method**: Screen shader approach using `hyprshade`
- **Shader**: Custom GLSL fragment shader that reduces blue component by 20%
- **Persistence**: Auto-applies in new terminal sessions
- **Manual Control**: Keybindings for instant on/off

### Internet Speed Testing
- **Tool**: `speedtest-cli` for command-line speed testing
- **Usage**: `speedtest-cli` command available system-wide

## Technical Notes

### Why hyprshade Works
- Uses Hyprland's native screen shader system
- Runs at compositor level (GPU-accelerated)
- No dependency on X11 gamma adjustment APIs
- Works reliably with Wayland

### Bash Profile Integration
- Blue light filter auto-applies in new terminals
- Checks for Wayland environment before applying
- Fails silently if hyprshade unavailable

## Next Steps
1. Test blue light filter persistence across reboots
2. Consider adding automatic temperature scheduling
3. Monitor Hyprland stability with new configuration
4. Document any additional keybinding needs

## Commands for Testing
```bash
# Test blue light filter
hyprshade on blue-light-filter
hyprshade off

# Test internet speed
speedtest-cli

# Emergency Hyprland recovery
Super + Shift + Escape  # Kill Hyprland
Super + Ctrl + R        # Reload Hyprland
```

## Session Summary
- ✅ Hyprland stability improvements implemented
- ✅ Working blue light filter with hyprshade
- ✅ Internet speed testing capability added
- ✅ Emergency recovery keybindings configured
- ✅ Auto-application of blue light filter in terminals
- ✅ Comprehensive backup and documentation created
