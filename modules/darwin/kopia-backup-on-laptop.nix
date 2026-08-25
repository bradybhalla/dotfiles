# Kopia backups to run on my laptop. Assumes the repository is already connected for ${user} (with the --no-use-keychain flag) and that the snapshot sources are configured in kopia itself. See your org-roam notes on kopia setup for macOS to fix any permission or password issues.

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
  # make launchd daemon so it runs when nobody is logged in
  launchd.daemons.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.kopia)
        "snapshot"
        "create"
        "--all"
      ];

      UserName = user;

      EnvironmentVariables = {
        HOME = home;
        # TODO: rclone can be removed if I ever switch to a different storage than Dropbox
        PATH = "${pkgs.rclone}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      };

      # it seems like I need to restart for this to take effect?
      StartCalendarInterval = [
        {
          Hour = 4;
          Minute = 0;
        }
      ];

      StandardOutPath = "${home}/Library/Logs/kopia-backup.log";
      StandardErrorPath = "${home}/Library/Logs/kopia-backup.log";
    };
  };
}
