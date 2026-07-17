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
      "firefox@developer-edition"
      "emacs-app"
      "1password"
      "spotify"
      "karabiner-elements"
      "nikitabobko/tap/aerospace"
      "tailscale-app"
      "dropbox"

      "docker-desktop"
      "skim"
      "appcleaner"
      "daisydisk"
      "balenaetcher"
      "moonlight"
      "utm"
      "rectangle"

      "steam"
      "zoom"
      "discord"
      "slack"

      "iterm2"
      "sublime-text"
      "google-chrome"
      "visual-studio-code"
      "arduino-ide"
      "raspberry-pi-imager"
    ];
    brews = [
      "ghcup"
    ];
  };

  system.defaults = {
    dock = {
      tilesize = 84; # dock icon size in pixels
      autohide = true; # hide the dock until hovered
      mru-spaces = false; # don't auto-reorder Spaces by recent use
      show-recents = false; # hide the recent apps section of the dock

      wvous-br-corner = 1; # don't make quick note when mouse is in corner

      # apps in the dock
      persistent-apps = [
        "/Applications/Firefox Developer Edition.app"
        "/Applications/Spotify.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/System Settings.app"
      ];
    };

    finder = {
      ShowPathbar = true; # show the path breadcrumbs at the bottom of the finder window
      AppleShowAllFiles = true; # show hidden files by default
      QuitMenuItem = true; # allow quitting Finder with CMD-Q
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark"; # dark mode
      AppleShowAllExtensions = true; # always show file extensions
      ApplePressAndHoldEnabled = false; # holding a key repeats it instead of accent popup
      KeyRepeat = 2; # faster key repeat rate (lower is faster)
      InitialKeyRepeat = 25; # shorter delay before repeat starts (lower is shorter)
    };

    WindowManager.EnableStandardClickToShowDesktop = false; # don't reveal desktop on click of empty area
  };

  system.stateVersion = 7;
}
