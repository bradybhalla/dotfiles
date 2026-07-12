# macOS-specific tools and dotfiles (aerospace, skhd, karabiner)

{
  config,
  pkgs,
  linkHere,
  lib,
  ...
}:
{
  programs.zsh.shellAliases = {
    firefox = "open -a Firefox\\ Developer\\ Edition";
  };

  # needs mkAfter because otherwise path is overwriten
  programs.zsh.initContent = lib.mkAfter ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  home.packages = with pkgs; [
    pngpaste
    skhd
  ];

  home.file = {
    ".aerospace.toml".source = linkHere ".aerospace.toml";
    ".config/skhd/skhdrc".source = linkHere ".config/skhd/skhdrc";
    ".config/karabiner/karabiner.json".source = linkHere ".config/karabiner/karabiner.json";
  };
}
