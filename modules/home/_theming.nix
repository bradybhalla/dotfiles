# NOTE: the _ prefix means this is imported by another module (hyprland-desktop.nix),
# not directly by the main config.

# general theming of GUIs
# - catppuccin themes for gtk and qt
# - sets things to dark mode where possible

# TODO: clean this up and move back into hyprland-desktop

{
  pkgs,
  config,
  ...
}:
{
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
