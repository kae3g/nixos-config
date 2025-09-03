{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xx";
  home.homeDirectory = "/home/xx";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bluebubbles
    pkgs.brave
    pkgs.code-cursor
    pkgs.discord
    pkgs.docker
    pkgs.emacs
    pkgs.git
    pkgs.gnupg
    pkgs.kakoune
    pkgs.meson
    pkgs.neovim
    pkgs.networkmanagerapplet
    pkgs.nodejs_24
    pkgs.nodePackages.pnpm
    pkgs.nodePackages.yarn
    pkgs.nushell
    pkgs.ollama
    pkgs.open-webui
    pkgs.oterm
    pkgs.pinentry
    pkgs.python3
    pkgs.screen
    pkgs.signal-desktop
    pkgs.spotify
    pkgs.swww # for hyprland wallpapers
    pkgs.tmux
    pkgs.uv
    pkgs.vim
    pkgs.wayland-protocols
    pkgs.wayland-utils
    pkgs.wl-clipboard
    pkgs.wlroots
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xwayland
    pkgs.zed-editor
    pkgs.zellij
    pkgs.zsh
    # Essential Hyprland packages
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.rofi-wayland
    pkgs.grim
    pkgs.slurp
    pkgs.wf-recorder
    pkgs.cliphist    # ADDED: for clipboard management
    pkgs.nautilus    # ADDED: alternative file manager
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Hyprland wallpaper
    ".config/hypr/hyprpaper.conf".text = ''
      preload = /home/xx/Pictures/wallpaper.jpg
      wallpaper = ,/home/xx/Pictures/wallpaper.jpg
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/xx/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "nvim";
    # FIXED: Enhanced Wayland support for Chromium/Electron applications
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    # Additional environment variables for better compatibility
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Let Home Manager manage shell configuration
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Disable Home Manager unstable nixpkgs warning
  home.enableNixpkgsReleaseCheck = false;

  # Git configuration
  programs.git = {
   enable = true;
   userName  = "kae3g";
   userEmail = "kj3x39@gmail.com";
   extraConfig = {
     commit.gpgsign = true;
     tag.gpgSign = true;               
     user.signingkey = "374AC48A537583C9"; 
   };
 }; 

# gnupg
services = {
    gnome-keyring.enable = true;
    gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        enableSshSupport = true;
    };
};

programs.gpg.enable = true;

# FIXED: Enhanced Chromium/Electron configuration
programs.chromium = {
  enable = true;
  package = pkgs.brave;
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

# FIXED: Cursor editor configuration
programs.vscode = {
  enable = true;
  package = pkgs.code-cursor;
  extensions = with pkgs.vscode-extensions; [
    # Add any extensions you want here
  ];
  userSettings = {
    "window.titleBarStyle" = "custom";
    "window.useNativeTitleBar" = false;
  };
};

# Enable Hyprland
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    
    # Add a complete configuration with keybindings
    settings = {
      monitor = ",preferred,auto,1";
      
      exec-once = [
        "waybar"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # FIXED: Start desktop portal for better app compatibility
        "systemctl --user start xdg-desktop-portal-hyprland"
        "systemctl --user start xdg-desktop-portal-gtk"
      ];
      
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };
      
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      
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
      
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      master = {
        new_is_master = true;
      };
      
      gestures = {
        workspace_swipe = "off";
      };
      
      misc = {
        force_default_wallpaper = -1;
      };
      
      # Keybindings - FIXED!
      "$mainMod" = "SUPER";
      
      bind = [
        # FIXED: Added Super+Enter for terminal
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, exec, kitty"          # Keep Q as alternative
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
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
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, S, exec, grim - | wl-copy"
        # Additional useful keybindings
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod, F, fullscreen, 1"
        "$mainMod SHIFT, F, fullscreen, 0"
        # FIXED: Add keybindings for Brave and Cursor
        "$mainMod, B, exec, brave --enable-wayland-ime --ozone-platform=wayland --enable-features=UseOzonePlatform"
        "$mainMod, D, exec, cursor --enable-wayland-ime --ozone-platform=wayland --enable-features=UseOzonePlatform"
      ];
      
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  # For Hyprland Waybar
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
