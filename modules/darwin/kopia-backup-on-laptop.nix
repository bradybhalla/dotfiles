# Kopia backups to run on the laptop host, to the same rclone repository the desktop
# backs up to. Assumes the repository is already connected for ${user} and that the
# snapshot sources are configured in kopia itself.

{
  pkgs,
  lib,
  ...
}:

let
  user = "brady";
  home = "/Users/${user}";
in
{
  # a daemon rather than a user agent, so it runs when nobody is logged in
  launchd.daemons.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.kopia)
        "snapshot"
        "create"
        "--all"
      ];

      UserName = user;

      # launchd daemons get a bare environment: kopia needs HOME to find its config,
      # and its rclone backend spawns `rclone serve webdav` off PATH
      EnvironmentVariables = {
        HOME = home;
        PATH = "${pkgs.rclone}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };

      # launchd cannot wake a sleeping Mac: if it is asleep at 04:00 the backup runs at
      # the next wake instead. Sleep behaviour is configured by hand in System Settings,
      # not from here.
      StartCalendarInterval = [
        {
          Hour = 4;
          Minute = 0;
        }
      ];

      StandardOutPath = "/var/log/kopia-backup.log";
      StandardErrorPath = "/var/log/kopia-backup.log";
    };
  };
}
