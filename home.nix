{ config, pkgs, ... }:

{
  # Basic Home Manager configuration
  home.username = "xx";
  home.homeDirectory = "/home/xx";
  home.stateVersion = "25.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Disable Home Manager unstable nixpkgs warning
  home.enableNixpkgsReleaseCheck = false;

  # Packages
  home.packages = with pkgs; [
    # Development tools
    git
    neovim
    emacs
    kakoune
    vim
    zed-editor
    code-cursor
    docker
    meson
    python3
    uv
    nodejs_24
    nodePackages.pnpm
    nodePackages.yarn
    nushell
    zsh
    tmux
    zellij
    screen

    # System utilities
    gnupg
    pinentry
    networkmanagerapplet
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland

    # Hyprland ecosystem
    waybar
    hyprpaper
    rofi-wayland
    grim
    slurp
    wf-recorder
    cliphist
    hyprsunset
    swww

    # Applications
    brave
    discord
    signal-desktop
    spotify
    bluebubbles
    ollama
    open-webui
    oterm
    nautilus
    speedtest-cli
  ];

  # Environment variables
  home.sessionVariables = {
    # Wayland support
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # Shell configurations
  programs.bash = {
    enable = true;
    shellAliases = {
      speedtest = "speedtest --secure";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      speedtest = "speedtest --secure";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "kae3g";
    userEmail = "kj3x39@gmail.com";
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgSign = true;
      user.signingkey = "801E24E10E8FA29C";
    };
  };

  # GPG configuration
  programs.gpg.enable = true;

  # Services
  services = {
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gtk2;
    };
  };

  # Chromium/Brave configuration
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-wayland-ime"
      "--ozone-platform=wayland"
      "--enable-features=UseOzonePlatform"
      "--disable-gpu-sandbox"
      "--enable-unsafe-webgpu"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--disable-dev-shm-usage"
      "--no-sandbox"
      "--disable-setuid-sandbox"
    ];
  };

  # VS Code/Cursor configuration
  programs.vscode = {
    enable = true;
    package = pkgs.code-cursor;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Add extensions here
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.useNativeTitleBar" = false;
        
        # Terminal environment variables for GPG support
        "terminal.integrated.env.linux" = {
          "GPG_TTY" = "$(tty)";
          "GNOME_KEYRING_CONTROL" = "$XDG_RUNTIME_DIR/keyring";
          "SSH_AUTH_SOCK" = "$XDG_RUNTIME_DIR/keyring/ssh";
          # Additional GPG environment variables
          "GPG_AGENT_INFO" = "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent";
        };
        
        # Git configuration for GPG signing
        "git.enableCommitSigning" = true;
        "git.gpgPath" = "gpg";
        "git.signingKey" = "801E24E10E8FA29C";  # Your main GPG key ID
        "git.autoStash" = true;
        "git.confirmSync" = false;
        
        # Cursor-specific Git settings
        "git.useCommitInputAsStashMessage" = true;
        "git.showProgress" = "always";
        "git.allowNoVerifyCommit" = false;
        "git.allowCommitSigning" = true;
        "git.autoFetch" = true;
        "git.autofetch" = true;
        
        # Terminal settings
        "terminal.integrated.shell.linux" = "/home/xx/.nix-profile/bin/zsh";
        "terminal.integrated.inheritEnv" = true;
      };
    };
  };

  # Hyprland configuration
  programs.kitty.enable = true;
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Startup programs
      exec-once = [
        "waybar"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "systemctl --user start xdg-desktop-portal-hyprland"
        "systemctl --user start xdg-desktop-portal-gtk"
        "hyprsunset"
      ];
      
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0;
      };
      
      # General appearance
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
      
      # Animations
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      # Layout configurations
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      gestures = {
        workspace_swipe = "off";
      };
      
      misc = {
        force_default_wallpaper = -1;
      };
      
      # Keybindings
      "$mainMod" = "SUPER";
      
      bind = [
        # Basic navigation
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        
        # Window focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        
        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # Move windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # Mouse workspace switching
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        
        # Screenshots
        "$mainMod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, S, exec, grim - | wl-copy"
        
        # Additional keybindings
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen, 0"
        
        # Application launchers
        "$mainMod, B, exec, brave --enable-wayland-ime --ozone-platform=wayland --enable-features=UseOzonePlatform"
        "$mainMod, D, exec, cursor --enable-wayland-ime --ozone-platform=wayland --enable-features=UseOzonePlatform"
        
        # Blue light filter toggle
        "$mainMod SHIFT, B, exec, $HOME/nixos-config-backup/scripts/hyprsunset-toggle.sh"
      ];
      
      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  # Hyprland wallpaper configuration
  home.file = {
    ".config/hypr/hyprpaper.conf".text = ''
      preload = /home/xx/Pictures/wallpaper.jpg
      wallpaper = ,/home/xx/Pictures/wallpaper.jpg
    '';
  };

  # Waybar overlay for experimental features
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
