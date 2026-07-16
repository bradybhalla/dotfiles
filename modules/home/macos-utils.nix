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
    defaultbrowser
  ];

  home.file = {
    ".aerospace.toml".source = linkHere ".aerospace.toml";
    ".config/skhd/skhdrc".source = linkHere ".config/skhd/skhdrc";
    ".config/karabiner/karabiner.json".source = linkHere ".config/karabiner/karabiner.json";
  };

  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${pkgs.defaultbrowser}/bin/defaultbrowser firefoxdeveloperedition
  '';

  home.activation.setWallpaper =
    let
      wallpaper = ../../assets/wallpapers/sunset1.jpg;
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run echo "setting desktop wallpaper..." >&2
      run /usr/bin/osascript -e '
        tell application "System Events"
          tell every desktop to set picture to "${wallpaper}"
        end tell
      '
    '';
}
