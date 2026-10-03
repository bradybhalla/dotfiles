# Hyprland desktop environment: bar, launcher, notifications, and themes

{
  config,
  pkgs,
  linkHere,
  ...
}:
{
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
    rofi # drun
    wl-clipboard # wl-copy / wl-paste clipboard
    pamixer # volume cli
    playerctl # control playing audio
    cava # visualize live audio
    eww # desktop widgets
    jq # json parsing for waybar and eww scripts
    pavucontrol # audio device setttings
  ];

  services.swayosd.enable = true; # on-screen display for volume/media/brightness (systemd user service, started after compositor)
  services.playerctld.enable = true;
  services.network-manager-applet.enable = true;
  services.udiskie.enable = true; # automount removable media (needs services.udisks2)
  services.streamdeck.enable = true; # stream deck daemon, idles until one is plugged in (flake input)

  home.pointerCursor = {
    enable = true;
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

  # theming: catppuccin frappe for gtk and qt, dark mode where possible
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-frappe-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "frappe";
        accents = [ "blue" ];
        size = "standard";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.theme = config.gtk.theme;
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    kvantum = {
      enable = true;
      themes = [
        (pkgs.catppuccin-kvantum.override {
          variant = "frappe";
          accent = "blue";
        })
      ];
      settings.General.theme = "catppuccin-frappe-blue";
    };
  };
}
