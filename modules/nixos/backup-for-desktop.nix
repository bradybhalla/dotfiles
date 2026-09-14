# Kopia backups to run on my desktop (including self-hosted services). Assumes the repository is already connected for ${user} and that the snapshot sources are configured in kopia itself.

{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "brady";
  dumpDir = "/var/lib/self-hosting-dumps";

  # What each source excludes lives in the kopia policy itself, see
  # dotfiles/kopia-backup-policy.py
  snapshotPaths = [
    "/home/${user}"
    dumpDir # safe database dumps
    "/var/lib/self-hosting" # live app states
    "/var/lib/self-hosting-media" # larger media / assets
  ];

  # Dumps the self-hosted databases into ${dumpDir}, which is one of the sources
  # kopia snapshots
  dumpScript = pkgs.writeShellApplication {
    name = "dump-dbs-before-kopia-backup";
    runtimeInputs = [
      pkgs.sqlite
      config.virtualisation.docker.package
    ];
    # TODO: notify on failure
    text = ''
      # Forgejo database
      sqlite3 "/var/lib/self-hosting/forgejo/gitea/forgejo.db" ".backup '${dumpDir}/forgejo.db'"

      # Miniflux database
      docker exec miniflux-db-1 sh -c 'pg_dumpall -U "$POSTGRES_USER"' \
        > "${dumpDir}/miniflux.sql"

      # Kavita database
      sqlite3 "/var/lib/self-hosting/kavita/kavita.db" ".backup '${dumpDir}/kavita.db'"
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

    serviceConfig = {
      Type = "oneshot";
      User = user;
      ExecStartPre = lib.getExe dumpScript;
      ExecStart = "${lib.getExe pkgs.kopia} snapshot create ${lib.escapeShellArgs snapshotPaths}";
    };
  };

  systemd.timers.kopia-backup = {
    description = "Daily Kopia backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
  };
}
