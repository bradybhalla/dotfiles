{
  config,
  lib,
  pkgs,
  ...
}:

{
  system.primaryUser = "brady";

  networking = {
    computerName = "Brady's MacBook Pro";
    hostName = "brady-macbook-pro";
    localHostName = "brady-macbook-pro";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "alacritty"
      "karabiner-elements"
      "nikitabobko/tap/aerospace"
      "emacs-app"
      "tailscale-app"

      "appcleaner"
      "daisydisk"
      "rectangle"
      "skim"
      "balenaetcher"
      "moonlight"

      "dropbox"
      "steam"
      "zoom"
      "docker-desktop"

      "1password"
      "firefox@developer-edition"
      "spotify"
      "iterm2"
      "utm"
      "slack"
      "sublime-text"
      "discord"
      "google-chrome"
      "visual-studio-code"
      "zotero"
      "arduino-ide"
      "raspberry-pi-imager"
    ];
    brews = [
      "ghcup"
    ];
  };

  system.defaults = {
    dock = {
      tilesize = 84;
      autohide = true;
      mru-spaces = false;

      wvous-br-corner = 1; # 1 = disabled — kills the default Quick Note corner

      # Finder is always pinned leftmost by macOS, so it's not listed here.
      persistent-apps = [
        "/Applications/Firefox Developer Edition.app"
        "/Applications/Alacritty.app"
        "/Applications/Spotify.app"
        "/System/Applications/Messages.app"
      ];
    };

    finder = {
      ShowPathbar = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 25;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;
  };

  system.stateVersion = 7;
}
