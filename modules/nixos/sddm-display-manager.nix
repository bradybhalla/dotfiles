{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    bibata-cursors # cursor theme for the SDDM greeter (see below)
  ];

  programs.silentSDDM = {
    enable = true;
    theme = "default";
    backgrounds = {
      "mountain-background.jpg" = ../../assets/mountain-background.jpg;
    };
    settings = {
      "General" = {
        scale = 2;
      };
      "LockScreen" = {
        display = true;
        background = "mountain-background.jpg";
        blur = 64;
      };
      "LockScreen.Message" = {
        display-icon = false;
      };
      "LoginScreen" = {
        background = "mountain-background.jpg";
      };
    };
  };
  services.displayManager.sddm.settings.Theme = {
    CursorTheme = "Bibata-Modern-Classic";
    CursorSize = 48;
  };
  # CursorTheme alone doesn't reach the greeter: Qt 6 loads X11 cursors via
  # libxcb-cursor, which ignores the XCURSOR_THEME env var sddm sets and only
  # reads the Xcursor.theme/Xcursor.size X resources from the root window.
  services.displayManager.sddm.setupScript = ''
    ${pkgs.xrdb}/bin/xrdb -merge <<EOF
    Xcursor.theme: Bibata-Modern-Classic
    Xcursor.size: 48
    EOF
    XCURSOR_PATH=/run/current-system/sw/share/icons ${pkgs.xsetroot}/bin/xsetroot -cursor_name left_ptr
  '';
}
