{
  config,
  pkgs,
  dotfilesRepoDir,
  ...
}:
{
  home.packages = with pkgs; [
    hyprland
    hyprlauncher
    hyprshutdown
    hyprlock

    waybar

    playerctl
    brightnessctl
    networkmanagerapplet
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${dotfilesRepoDir}/dotfiles/backgrounds/ocean-background.jpg"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "${dotfilesRepoDir}/dotfiles/backgrounds/ocean-background.jpg";
        }
      ];
      splash = false;
    };
  };

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
      ".config/hypr/catppuccin-macchiato.lua".source = linkHere ".config/hypr/catppuccin-macchiato.lua";
      ".config/hypr/hyprland.lua".source = linkHere ".config/hypr/hyprland.lua";
      ".config/hypr/hyprlock.conf".source = linkHere ".config/hypr/hyprlock.conf";
      ".config/hypr/hyprtoolkit.conf".source = linkHere ".config/hypr/hyprtoolkit.conf";
      ".config/waybar".source = linkHere ".config/waybar";
    };
}
