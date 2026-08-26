# Kopia backups to run on the laptop, to the same rclone repository the desktop
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

  backupScript = pkgs.writeShellApplication {
    name = "kopia-backup";
    runtimeInputs = [
      pkgs.kopia
      # TODO: rclone can be removed if I ever switch to a different storage than Dropbox
      pkgs.rclone
    ];
    text = ''
      kopia snapshot create ${lib.escapeShellArgs snapshotPaths}
    '';
  };
in
{
  # make launchd daemon so it runs when nobody is logged in
  launchd.daemons.kopia-backup = {
    serviceConfig = {
      ProgramArguments = [ (lib.getExe backupScript) ];

      UserName = user;

      EnvironmentVariables = {
        HOME = home;
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
