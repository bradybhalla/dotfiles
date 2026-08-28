# Kopia backups to run on the laptop, to the same repository the desktop
# backs up to. Assumes the repository is already connected for ${user} and that the
# snapshot sources are configured in kopia itself.

# NOTE: after making changes either reboot or run the following command
#   launchctl unload ~/Library/LaunchAgents/org.nixos.kopia-backup.plist
#   launchctl load ~/Library/LaunchAgents/org.nixos.kopia-backup.plist

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
  # note that the launchd agent is added for the nix darwin primaryUser and only runs when they are logged in
  launchd.user.agents.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.kopia)
        "snapshot"
        "create"
      ]
      ++ snapshotPaths;

      EnvironmentVariables = {
        HOME = home;
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
