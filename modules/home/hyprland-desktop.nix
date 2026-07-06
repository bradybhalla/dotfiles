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
    hyprsunset
    hyprsysteminfo

    pamixer # volume cli
    playerctl # control playing audio
    cava # visualize live audio
    eww # desktop widgets

    procps # needed a different 'uptime'

    # TODO: maybe move to linux apps
    pavucontrol # audio device setttings
  ];

  services.playerctld.enable = true;
  services.network-manager-applet.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home.file =
    let
      linkHere = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";
    in
    {
      ".config/hypr".source = linkHere ".config/hypr";
      ".config/waybar".source = linkHere ".config/waybar";
      ".config/eww".source = linkHere ".config/eww";
    };
}
