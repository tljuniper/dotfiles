{ pkgs, config, ... }:

let
  home-assistant-dir = if config.networking.hostName == "pascal" then "/data/home-assistant" else "/home/juniper/home-assistant";
in
{
  virtualisation.oci-containers.containers.home-assistant = {
    volumes = [ "${home-assistant-dir}:/config" ];
    environment.TZ = "Europe/Berlin";
    image = "ghcr.io/home-assistant/home-assistant:2024.5"; # Months formatted with one digit if possible, e.g. "2024.3"
    extraOptions = [
      "--network=host"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    8123 # Home assistant web UI
    1883 # Mosquitto
  ];

  environment.systemPackages = with pkgs; [
    sqlite-interactive
    # For testing with mosquitto_pub and for generating password files with mosquitto_passwd
    mosquitto
  ];

  services.mosquitto = {
    enable = true;
    logType = [ "all" ];
    listeners = [
      {
        port = 1883;
        users = {
          esp-water-meter = {
            # Hashes generated by using mosquitto_passwd and extracting the second field
            # See NixOS options doc
            hashedPassword = "$7$101$39mT4ByzZgkt+V5h$0icwVVmOgazrzz11AqXC1v2xhWd08/PzMRzbYjNLK2Hv85LI4qb7thFm/rqwdBGGHUY5MAijHkLnUZDsueM+dw==";
            acl = [
              "readwrite watermeter/#"
              "readwrite homeassistant/sensor/watermeter/#"
            ];
          };
          opendtu = {
            hashedPassword = "$7$101$qn8M/mVdkiUQ7P5r$vlU+21lXFXwgMq4+W2iM3guDZ3eOWiTOzoQNsKulvjsDINA9jVwmpI5sc1DFsEfIUIIehHVlZ+iJgVk8h7kz1Q==";
            acl = [
              "readwrite solar/#"
              "readwrite homeassistant/#"
            ];
          };
          ha_user = {
            hashedPassword = "$7$101$jk+9uKedIA4EWQ/Z$Gb5d7fl9rXCjSCeE0zs3C9G/0IsmOaSO6zoBf+hz+wt9tvRfYLcHgr1OpSM3vL6Jk47Np1E7p7nUQ8zg17LUiQ==";
            acl = [
              "read #"
              "readwrite homeassistant/#"
            ];
          };
        };
      }
    ];
  };

  systemd.services.home-assistant-backup = {
    description = "Backup service for HA";
    after = [ "network.target" ];
    script = ''
      #!/usr/bin/env bash

      set -euo pipefail

      readonly SOURCE_DIR="${home-assistant-dir}/backups"
      readonly BACKUP_DIR="/backup/home-assistant"
      readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
      readonly BACKUP_PATH="''${BACKUP_DIR}/''${DATETIME}"
      readonly LATEST_LINK="''${BACKUP_DIR}/latest"

      mkdir -p "''${BACKUP_DIR}"

      # --dry-run
      ${pkgs.rsync}/bin/rsync --verbose --archive \
        "''${SOURCE_DIR}/" \
        --link-dest "''${LATEST_LINK}" \
        "''${BACKUP_PATH}"

      rm -rf "''${LATEST_LINK}"
      ln -s "''${BACKUP_PATH}" "''${LATEST_LINK}"
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.timers.home-assistant-backup-timer = {
    description = "Backup timer for HA backup";
    partOf = [ "home-assistant-backup.service" ];
    wantedBy = [ "timers.target" ];
    # Home Assistant backup runs at 3:00
    timerConfig = {
      OnCalendar = "*-*-* 03:30:00";
      # Don't launch the service if it couldn't run the last time
      # Slows down the server too much if run during the day
      Persistent = false;
      Unit = "home-assistant-backup.service";
    };
  };
}
