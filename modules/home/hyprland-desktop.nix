{
  pkgs,
  linkHere,
  ...
}:
{
  imports = [ ./theming.nix ];

  home.packages = with pkgs; [
    waybar # status bar

    hyprland # window manager, installed globally but I need cli tools
    hyprshutdown # logout nicely
    hyprlock # lock screen
    hyprpaper # wallpaper
    hyprsunset # night mode
    hyprsysteminfo # about screen

    rofi

    pamixer # volume cli
    playerctl # control playing audio
    cava # visualize live audio
    eww # desktop widgets

    procps # needed a different 'uptime'

    spotify

    # TODO: maybe move to linux apps
    pavucontrol # audio device setttings
    nemo # file manager
  ];

  services.playerctld.enable = true;
  services.network-manager-applet.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };


  home.file = {
    ".config/hypr".source = linkHere ".config/hypr";
    ".config/waybar".source = linkHere ".config/waybar";
    ".config/eww".source = linkHere ".config/eww";
    ".config/rofi".source = linkHere ".config/rofi";
  };
}
