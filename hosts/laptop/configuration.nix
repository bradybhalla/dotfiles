{
  pkgs,
  ...
}:

{

  system.primaryUser = "bradybhalla";

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

  system.stateVersion = 7;
}
