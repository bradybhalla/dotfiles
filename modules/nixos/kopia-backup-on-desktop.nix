# Kopia backups to run on my desktop (including self-hosted services). Assumes the repository is already connected for ${user} and that the snapshot sources are configured in kopia itself.

{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "brady";
  dumpDirName = "self-hosting-db-backup";
  dumpDir = "/var/lib/${dumpDirName}";
  forgejoData = "/var/lib/self-hosting/forgejo";
  minifluxDbContainer = "miniflux-db-1";

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
      ExecStartPre = lib.getExe dumpScript;
      ExecStart = "${lib.getExe pkgs.kopia} snapshot create --all";
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
