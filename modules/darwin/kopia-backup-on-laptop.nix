# Kopia backups to run on the laptop, to the same repository the desktop
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

  # What each source excludes lives in the kopia policy itself, see
  # dotfiles/kopia-backup-policy.py
  snapshotPaths = [
    home
    "${home}/Library"
    "${home}/Library/Messages"
    "${home}/Pictures/Photos Library.photoslibrary"
  ];
in
{
  # make launchd daemon so it runs when nobody is logged in
  launchd.daemons.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.kopia)
        "snapshot"
        "create"
      ]
      ++ snapshotPaths;

      UserName = user;

      EnvironmentVariables = {
        HOME = home;
      };

      # it seems like I need to restart for this to take effect?
      StartCalendarInterval = [
        {
          Hour = 3;
          Minute = 0;
        }
      ];

      StandardOutPath = "${home}/Library/Logs/kopia-backup.log";
      StandardErrorPath = "${home}/Library/Logs/kopia-backup.log";
    };
  };
}
