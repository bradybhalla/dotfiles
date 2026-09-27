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

  # tuigreet remembers sessions by .desktop path, so expose them at a path that
  # survives rebuilds instead of the per-generation /nix/store/<hash>-desktops
  environment.etc."greetd/wayland-sessions".source =
    "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";

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
      "--sessions /etc/greetd/wayland-sessions"
    ];
  };
}
