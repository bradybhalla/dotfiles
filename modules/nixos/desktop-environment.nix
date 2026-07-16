# Hyprland session enablement plus the SDDM (silentSDDM) login greeter
# TODO: clean up comments

{
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # electron apps should use wayland

  # SDDM greeter (silentSDDM)
  environment.systemPackages = with pkgs; [
    bibata-cursors # cursor theme for the SDDM greeter (see below)
  ];

  programs.silentSDDM = {
    enable = true;
    theme = "default";
    backgrounds = {
      "background.jpeg" = ../../assets/wallpapers/sunrise1.jpg;
    };
    settings = {
      "LockScreen" = {
        display = true;
        background = "background.jpeg";
        blur = 64;
      };
      # Font sizes below are scaled ~1.4x over the default theme to make
      # everything on the lock/login screens larger.
      "LockScreen.Clock" = {
        font-size = 96;
      };
      "LockScreen.Date" = {
        font-size = 20;
      };
      "LockScreen.Message" = {
        display-icon = false;
        font-size = 17;
      };
      "LoginScreen" = {
        background = "background.jpeg";
      };
      "LoginScreen.LoginArea.Username" = {
        font-size = 22;
      };
      "LoginScreen.LoginArea.PasswordInput" = {
        font-size = 17;
      };
      "LoginScreen.LoginArea.LoginButton" = {
        font-size = 17;
      };
      "LoginScreen.LoginArea.Spinner" = {
        font-size = 20;
      };
      "LoginScreen.LoginArea.WarningMessage" = {
        font-size = 15;
      };
      "LoginScreen.MenuArea.Popups" = {
        font-size = 15;
      };
      "LoginScreen.MenuArea.Session" = {
        font-size = 14;
      };
      "LoginScreen.MenuArea.Layout" = {
        font-size = 14;
      };
      "Tooltips" = {
        font-size = 15;
      };
    };
  };
  # The greeter runs on X11 (silentSDDM only uses Wayland when
  # services.xserver.enable is off) where nothing scales automatically, so
  # hardcode the monitor's Hyprland scale of 1.5: Qt 6 reads its scale factor
  # from the Xft.dpi resource (96 * 1.5 = 144). The cursor theme has to go
  # through X resources too: Qt 6 loads cursors via libxcb-cursor, which
  # ignores the XCURSOR_THEME env var sddm's Theme.CursorTheme would set.
  # Xcursor.size is in physical pixels: logical size 24
  # (home.pointerCursor.size in modules/home/hyprland-desktop.nix) * 1.5 = 36.
  services.displayManager.sddm.setupScript = ''
    ${pkgs.xrdb}/bin/xrdb -merge <<EOF
    Xft.dpi: 144
    Xcursor.theme: Bibata-Modern-Classic
    Xcursor.size: 36
    EOF
    XCURSOR_PATH=/run/current-system/sw/share/icons ${pkgs.xsetroot}/bin/xsetroot -cursor_name left_ptr
  '';
}
