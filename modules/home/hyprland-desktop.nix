{
  config,
  pkgs,
  ...
}:
let
  dotfilesRepoDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.packages = with pkgs; [
    waybar

    hyprland
    hyprlauncher
    hyprshutdown
    hyprlock
    hyprpaper

    pciutils
    pamixer
    cava
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk.enable = true;
  gtk.gtk4.theme = null;

  home.file =
    let
      linkHere = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";
    in
    {
      ".config/hypr".source = linkHere ".config/hypr";
      ".config/waybar".source = linkHere ".config/waybar";
      ".backgrounds".source = linkHere ".backgrounds";
    };
}
