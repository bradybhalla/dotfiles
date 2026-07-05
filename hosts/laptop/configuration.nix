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

      # add these after deleting the apps
      # "1password"
      # "firefox@developer-edition"
      # "spotify"
      # "iterm2" # backup terminal
      # "docker-desktop"
      # "utm"
    ];
    brews = [
      "ghcup"
    ];
  };

  system.stateVersion = 7;
}
