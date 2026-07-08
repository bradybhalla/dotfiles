# dropbox syncing using Maestral
# First time setup:
#   maestral auth link
#
# This module only runs the sync daemon. The system-tray applet is the GUI
# (the `maestral_qt` binary from maestral-gui, NOT `maestral gui` which fails
# on Nix) and is autostarted from hypr/hyprland.lua after the tray is ready.
#
# Home Manager has no built-in maestral module (services.dropbox is for the
# proprietary client), so the daemon is a hand-written user service.

# TODO: maestral is no longer being maintained so find a replacement

{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    maestral
    maestral-gui
  ];

  systemd.user.services.maestral = {
    Unit = {
      Description = "Maestral daemon";
    };
    Service = {
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Type = "notify";
      NotifyAccess = "exec";
      WatchdogSec = "30s";
      Restart = "on-failure";
      Nice = 10;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
