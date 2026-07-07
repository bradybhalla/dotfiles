{
  pkgs,
  linkHere,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    waybar # status bar

    hyprland # window manager
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
  ];

  services.playerctld.enable = true;
  services.network-manager-applet.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # Everything Catppuccin Frappé (blue accent), matching the waybar/eww/hypr
  # colorschemes. Frappé is a dark flavour, so keep the desktop in dark mode:
  # this is propagated through xdg-desktop-portal-gtk so libadwaita/GTK4 apps
  # and Qt 6.5+ apps follow it too.
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;
    theme = {
      # GTK3 apps (pavucontrol, nm-applet, GTK file pickers) key off this name.
      name = "catppuccin-frappe-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "frappe";
        accents = [ "blue" ];
        size = "standard";
      };
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    # For older GTK3 apps that key off this flag rather than the portal.
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    # Keep the pre-26.05 default: apply the same Catppuccin theme to GTK4 apps.
    # Silences the home-manager deprecation warning without changing appearance.
    gtk4.theme = config.gtk.theme;
  };

  # hyprsysteminfo and friends are Qt6 apps, not GTK. Catppuccin has no native
  # Qt style, so route Qt through Kvantum and point it at the Frappé/blue theme.
  qt = {
    enable = true;
    # Installs the qt5/qt6 Kvantum style plugins and sets QT_STYLE_OVERRIDE.
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

  home.file = {
    ".config/hypr".source = linkHere ".config/hypr";
    ".config/waybar".source = linkHere ".config/waybar";
    ".config/eww".source = linkHere ".config/eww";
    ".config/rofi".source = linkHere ".config/rofi";
  };
}
