{
  pkgs,
  ...
}:

{
  system.primaryUser = "bradybhalla";

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
      "appcleaner"
      "daisydisk"
      "rectangle"
      "skim"
      "tailscale-app"
      "balenaetcher"
    ];
    brews = [
      "newsboat"
      "ghcup"
    ];
  };

  system.stateVersion = 7;
}
