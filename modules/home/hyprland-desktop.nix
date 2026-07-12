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
    hypridle # idle behavior
    hyprshot # screenshots
    swaynotificationcenter # notification daemon + control center
    libnotify # notify-send command
    swayosd # on-screen display for volume/media/brightness
    rofi # drun
    wl-clipboard # wl-copy / wl-paste clipboard
    pamixer # volume cli
    playerctl # control playing audio
    cava # visualize live audio
    eww # desktop widgets
    procps # needed a different 'uptime'
    pavucontrol # audio device setttings

    # dropbox replacement
    maestral # for cli
    maestral-gui # tray and daemon

    nemo # file manager
  ];

  services.playerctld.enable = true;
  services.network-manager-applet.enable = true;
  services.udiskie.enable = true; # automount removable media (needs services.udisks2)

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
    ".config/swaync".source = linkHere ".config/swaync";
    ".config/swayosd".source = linkHere ".config/swayosd";
  };
}
