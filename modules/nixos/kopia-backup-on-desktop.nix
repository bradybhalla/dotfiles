# Kopia backups to run on the desktop host. Backs up local files and self-hosted services

{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "brady";
  home = "/home/${user}";
  dumpDirName = "kopia-backup";
  dumpDir = "/var/lib/${dumpDirName}";
  forgejoData = "/var/self-hosting/forgejo";
  minifluxDbContainer = "miniflux-db-1";

  sources = [
    # local files
    "${home}/Desktop"
    "${home}/Documents"
    "${home}/Downloads"
    "${home}/Pictures"

    # self-hosting data
    forgejoData
    dumpDir
  ];

  backupScript = pkgs.writeShellApplication {
    name = "kopia-backup";
    runtimeInputs = [
      pkgs.kopia
      pkgs.sqlite
      config.virtualisation.docker.package
    ];
    text = ''
      # Forgejo database
      sqlite3 "${forgejoData}/gitea/forgejo.db" ".backup '${dumpDir}/forgejo.db'"

      # Miniflux database
      docker exec ${minifluxDbContainer} sh -c 'pg_dumpall -U "$POSTGRES_USER"' \
        > "${dumpDir}/miniflux.sql"

      # Take snapshot
      kopia snapshot create ${lib.escapeShellArgs sources}
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
      StateDirectory = dumpDirName;
      StateDirectoryMode = "0700";
      ExecStart = lib.getExe backupScript;
    };
  };

  systemd.timers.kopia-backup = {
    description = "Daily Kopia backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 04:00:00";
      # catch up after the machine was off at the scheduled time
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
  };
}
