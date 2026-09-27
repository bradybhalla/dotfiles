# Kopia backups to run on the laptop, to the same repository the desktop
# backs up to. Runs as root but with the kopia config in ${home}. Assumes the
# repository is already connected there and that the snapshot sources are configured
# in kopia itself.

# NOTE: after making changes either reboot or run the following command
#   sudo launchctl unload /Library/LaunchDaemons/org.nixos.kopia-backup.plist
#   sudo launchctl load /Library/LaunchDaemons/org.nixos.kopia-backup.plist

{
  pkgs,
  lib,
  ...
}:

let
  home = "/Users/brady";

  # What each source excludes lives in the kopia policy (see scripts/kopia-backup-policy.py)
  snapshotPaths = [
    home
    "${home}/Library"
    "${home}/Library/Messages"
    "${home}/Pictures/Photos Library.photoslibrary"
  ];
in
{
  # a daemon runs as root, even when no one is logged in
  launchd.daemons.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.kopia)
        "snapshot"
        "create"
      ]
      ++ snapshotPaths;

      EnvironmentVariables = {
        HOME = home; # use the kopia config in home
      };

      StartCalendarInterval = [
        {
          Hour = 2;
          Minute = 0;
        }
      ];

      StandardOutPath = "${home}/Library/Logs/kopia-backup.log";
      StandardErrorPath = "${home}/Library/Logs/kopia-backup.log";
    };
  };
}
