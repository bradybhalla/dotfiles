# macOS-specific tools and dotfiles (aerospace, skhd, karabiner)

{
  pkgs,
  linkHere,
  ...
}:
{
  programs.zsh.shellAliases = {
    firefox = "open -a Firefox\\ Developer\\ Edition";
  };

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
