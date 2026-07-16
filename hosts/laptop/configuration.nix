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

  system.activationScripts.postActivation.text =
    let
      wallpaper = ../../assets/ocean-background.jpg;
    in
    lib.mkAfter ''
      echo "setting desktop wallpaper..." >&2
      sudo -u ${config.system.primaryUser} osascript -e '
        tell application "System Events"
          tell every desktop to set picture to "${wallpaper}"
        end tell
      ' || true
    '';

  system.stateVersion = 7;
}
