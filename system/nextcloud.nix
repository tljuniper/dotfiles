{ config, pkgs, ... }:
let
  hostName = "rust.fable-clownfish.ts.net";
  certFile = "/var/lib/ssl/private/rust.fable-clownfish.ts.net.crt";
  certKeyFile = "/var/lib/ssl/private/rust.fable-clownfish.ts.net.key";
in
{
  # Actual Nextcloud Config
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    inherit hostName;
    https = true;
    maxUploadSize = "514M";

    # Get rid of broken RC4 cipher warning
    enableBrokenCiphersForSSE = false;

    logLevel = 0;
    logType = "file";

    config = {
      # Further forces Nextcloud to use HTTPS
      overwriteProtocol = "https";

      # Nextcloud PostegreSQL database configuration, recommended over using SQLite
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      dbpassFile = "/var/nextcloud-db-pass";

      adminuser = "admin";
      adminpassFile = "/var/nextcloud-admin-pass";
    };

    extraOptions = {
      # Attempt to fix "too many files error"
      "bulkupload.enabled" = false;

      # Make default app not dashboard
      "defaultapp" = "files";
    };
  };

  # Attempt to fix "too many files error"
  systemd.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';

  # Attempt to fix "too many files error"
  environment.etc."security/limits.conf".text =
    ''
      *       soft    nofile  65536
      *       hard    nofile  65536
    '';


  # Automated certificate renewal
  systemd.services.tailscale-cert-renewal = {
    description = "Run tailscale cert to update certs";
    after = [ "network.target" ];
    script = ''
      #!/usr/bin/env bash
      set -xeou pipefail
      ${pkgs.tailscale}/bin/tailscale cert --cert-file ${certFile} --key-file ${certKeyFile} ${hostName}
      chown nginx:nginx ${certFile}
      chown nginx:nginx ${certKeyFile}
      # Restart nginx service so that new certs are used
      systemctl try-restart nginx.service
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.timers.tailscale-cert-renewal-timer = {
    description = "Timer for renewal of tailscale cert";
    partOf = [ "tailscale-cert-renewal.service" ];
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Run every two months on the 13th
      OnCalendar = "*-2,4,6,8,10,12-13 16:37:00";
      # Launch the service even if the system was turned off last time the timer triggered
      Persistent = true;
      Unit = "tailscale-cert-renewal.service";
    };
  };

  # Enable Nginx
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Setup Nextcloud virtual host to listen on ports
    virtualHosts = {
      "${hostName}" = {
        # Force HTTP redirect to HTTPS
        forceSSL = true;
        listen = [
          {
            addr = "0.0.0.0";
            port = 4000;
            ssl = true;
          }
        ];
        # Run "tailscale cert $hostName", then place certs in directory
        sslCertificate = certFile;
        sslCertificateKey = certKeyFile;
      };
    };
  };


  # Enable PostgreSQL
  services.postgresql = {
    enable = true;

    # Ensure the database, user, and permissions always exist
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      }
    ];
  };

  # Ensure that postgres is running before running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

  networking.firewall.allowedTCPPorts = [ 4000 ];

  systemd.services.nextcloud-backup = {
    description = "Backup service for nextcloud data";
    after = [ "network.target" ];
    script = ''
      #!/usr/bin/env bash

      set -euo pipefail

      readonly SOURCE_DIR="/var/lib/nextcloud"
      readonly BACKUP_DIR="/backup/nextcloud"
      readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
      readonly BACKUP_PATH="''${BACKUP_DIR}/''${DATETIME}"
      readonly LATEST_LINK="''${BACKUP_DIR}/latest"

      mkdir -p "''${BACKUP_DIR}"

      # Backup nextcloud files dir
      ${pkgs.rsync}/bin/rsync --verbose --archive \
        "''${SOURCE_DIR}/" \
        --link-dest "''${LATEST_LINK}" \
        "''${BACKUP_PATH}"

      # Backup database
      ${pkgs.sudo}/bin/sudo -u postgres ${pkgs.postgresql}/bin/pg_dump nextcloud -f /tmp/nextcloud-db.bak
      mv /tmp/nextcloud-db.bak ''${BACKUP_PATH}/

      rm -rf "''${LATEST_LINK}"
      ln -s "''${BACKUP_PATH}" "''${LATEST_LINK}"
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.timers.nextcloud-backup-timer = {
    description = "Backup timer for nextcloud data backup";
    partOf = [ "nextcloud-backup.service" ];
    wantedBy = [ "timers.target" ];
    # Home Assistant backup runs at 3:30
    timerConfig = {
      OnCalendar = "*-*-* 04:00:00";
      # Launch the service even if the system was turned off last time the timer triggered
      Persistent = true;
      Unit = "nextcloud-backup.service";
    };
  };
}
