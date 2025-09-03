# Enhanced Cursor editor configuration with GPG support
programs.vscode = {
  enable = true;
  package = pkgs.code-cursor;
  extensions = with pkgs.vscode-extensions; [
    # Add any extensions you want here
  ];
  userSettings = {
    "window.titleBarStyle" = "custom";
    "window.useNativeTitleBar" = false;
    
    # Terminal environment variables for GPG support
    "terminal.integrated.env.linux" = {
      "GPG_TTY" = "$(tty)";
      "GNOME_KEYRING_CONTROL" = "$XDG_RUNTIME_DIR/keyring";
      "SSH_AUTH_SOCK" = "$XDG_RUNTIME_DIR/keyring/ssh";
    };
    
    # Git configuration for Cursor
    "git.enableCommitSigning" = true;
    "git.gpgPath" = "gpg";
    
    # Terminal settings
    "terminal.integrated.shell.linux" = "/home/xx/.nix-profile/bin/zsh";
    "terminal.integrated.inheritEnv" = true;
    "terminal.integrated.env.osx" = {};
    "terminal.integrated.env.windows" = {};
  };
};
