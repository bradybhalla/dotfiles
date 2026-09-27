# Hyprland session enablement plus the greetd/tuigreet login greeter

{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # electron apps should use wayland

  environment.systemPackages = with pkgs; [
    kitty # so there is a terminal with the default hyprland config
  ];

  # simple login screen to start window manager
  services.greetd = {
    enable = true;
    useTextGreeter = true; # keeps systemd boot messages from scribbling over the TUI
    settings.default_session.command = lib.concatStringsSep " " [
      (lib.getExe pkgs.tuigreet)
      "--time"
      "--user-menu"
      "--remember"
      "--remember-user-session"
      "--asterisks"
      "--sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
    ];
  };
}
