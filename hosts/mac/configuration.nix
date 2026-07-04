{
  pkgs,
  ...
}:

{
  # Homebrew
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
    ];
    brews = [
      "newsboat"
      "ghcup"
    ];
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
