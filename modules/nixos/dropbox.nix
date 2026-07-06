# dropbox syncing using Maestral
# First time setup:
#   maestral auth link

# TODO: maestral is no longer being maintained so find a replacement

{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    maestral
    maestral-gui
  ];

  systemd.user.services.maestral = {
    description = "Maestral daemon";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Type = "notify";
      NotifyAccess = "exec";
      WatchdogSec = "30s";
      Restart = "on-failure";
      Nice = 10;
    };
  };
}
