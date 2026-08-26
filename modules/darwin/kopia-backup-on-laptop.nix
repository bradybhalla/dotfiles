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

  # Each snapshot source and the .kopiaignore installed at its root. An empty
  # string means nothing is excluded, so no file is written.
  snapshots = {
    "${home}".kopiaignore = ''
      /.Trash/
      /Library/
      /Pictures/Photos Library.photoslibrary/
    '';

    "${home}/Library".kopiaignore = ''
      /Messages/
      /Caches/
      /CloudStorage/
      /Mobile Documents/
      /Application Support/Steam/steamapps/common/
      /Application Support/Steam/steamapps/downloading/
      /Application Support/Steam/steamapps/shadercache/
    '';

    "${home}/Library/Messages".kopiaignore = "";

    "${home}/Pictures/Photos Library.photoslibrary".kopiaignore = "";
  };

  snapshotPaths = builtins.attrNames snapshots;

  # Runs at rebuild and again right before each backup, so a .kopiaignore that
  # goes missing in between can't leak into a snapshot
  installIgnoreFiles = pkgs.writeShellApplication {
    name = "install-kopiaignore-files";
    text = lib.concatLines (
      lib.mapAttrsToList (
        path: snapshot:
        "${pkgs.coreutils}/bin/install -D -m 0644 "
        + "${pkgs.writeText "kopiaignore" snapshot.kopiaignore} "
        + lib.escapeShellArg "${path}/.kopiaignore"
      ) (lib.filterAttrs (_: snapshot: snapshot.kopiaignore != "") snapshots)
    );
  };

  backupScript = pkgs.writeShellApplication {
    name = "kopia-backup";
    runtimeInputs = [
      pkgs.kopia
      # TODO: rclone can be removed if I ever switch to a different storage than Dropbox
      pkgs.rclone
    ];
    text = ''
      ${lib.getExe installIgnoreFiles}
      kopia snapshot create ${lib.escapeShellArgs snapshotPaths}
    '';
  };
in
{
  system.activationScripts.postActivation.text = lib.getExe installIgnoreFiles;

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
