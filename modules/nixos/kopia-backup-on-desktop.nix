# Kopia backups to run on my desktop (including self-hosted services). Assumes the repository is already connected for ${user} and that the snapshot sources are configured in kopia itself.

{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "brady";
  dumpDirName = "self-hosting-db-dumps";
  dumpDir = "/var/lib/${dumpDirName}";
  forgejoData = "/var/lib/self-hosting/forgejo";
  minifluxDbContainer = "miniflux-db-1";

  # Each snapshot source and the .kopiaignore installed at its root. An empty
  # string means nothing is excluded, so no file is written.
  snapshots = {
    "/home/${user}".kopiaignore = ''
      /Dropbox/
      /.ollama/models/
      /.local/share/Steam/steamapps/common/
      /.local/share/Steam/steamapps/downloading/
      /.local/share/Steam/steamapps/shadercache/
    '';

    "${dumpDir}".kopiaignore = "";

    # the live database is excluded because the dump below is snapshotted instead
    "${forgejoData}".kopiaignore = ''
      /gitea/forgejo.db
      /gitea/forgejo.db-wal
      /gitea/forgejo.db-shm
      /ssh/
    '';
  };

  snapshotPaths = builtins.attrNames snapshots;

  # Runs at rebuild and again right before each backup, so a .kopiaignore that
  # goes missing in between can't leak into a snapshot
  installIgnoreFiles = pkgs.writeShellApplication {
    name = "install-kopiaignore-files";
    text = lib.concatLines (
      lib.mapAttrsToList (
        path: snapshot:
        "${pkgs.coreutils}/bin/install -D -m 0644 -o ${user} "
        + "${pkgs.writeText "kopiaignore" snapshot.kopiaignore} "
        + lib.escapeShellArg "${path}/.kopiaignore"
      ) (lib.filterAttrs (_: snapshot: snapshot.kopiaignore != "") snapshots)
    );
  };

  # Dumps the self-hosted databases into ${dumpDir}, which is one of the sources
  # kopia snapshots
  dumpScript = pkgs.writeShellApplication {
    name = "dump-dbs-before-kopia-backup";
    runtimeInputs = [
      pkgs.sqlite
      config.virtualisation.docker.package
    ];
    text = ''
      # Forgejo database
      sqlite3 "${forgejoData}/gitea/forgejo.db" ".backup '${dumpDir}/forgejo.db'"

      # Miniflux database
      docker exec ${minifluxDbContainer} sh -c 'pg_dumpall -U "$POSTGRES_USER"' \
        > "${dumpDir}/miniflux.sql"
    '';
  };
in
{
  system.activationScripts.kopiaIgnoreFiles.text = lib.getExe installIgnoreFiles;

  systemd.services.kopia-backup = {
    description = "Kopia backup";
    after = [
      "network-online.target"
      "docker.service"
    ];
    wants = [ "network-online.target" ];
    requires = [ "docker.service" ];

    # TODO: if you stop using rclone then this isn't needed
    path = [ pkgs.rclone ];

    serviceConfig = {
      Type = "oneshot";
      User = user;
      StateDirectory = dumpDirName;
      StateDirectoryMode = "0700";
      ExecStartPre = [
        # "+" runs this as root, which is needed to write outside ${user}'s home
        "+${lib.getExe installIgnoreFiles}"
        (lib.getExe dumpScript)
      ];
      ExecStart = "${lib.getExe pkgs.kopia} snapshot create ${lib.escapeShellArgs snapshotPaths}";
    };
  };

  systemd.timers.kopia-backup = {
    description = "Daily Kopia backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 04:00:00";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
  };
}
