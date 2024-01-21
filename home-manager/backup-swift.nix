{ pkgs, ... }:
let
  script = pkgs.writeScript "backup.sh" ''
    #!/usr/bin/env bash
    set -euo pipefail

    notify-send "Swift backup" "Disk plugged in, starting backup..."
    start=`date +%s`

    # TODO: check switching from --include-from to --files-from
    # TODO: Add backup of dconf settings (dconf dump)
    # TODO: Add backups for browser bookmarks & settings
    readonly SOURCE_DIR="/home/juniper"
    readonly INCLUDES_FROM="/home/juniper/backup-files.txt"
    readonly BACKUP_DIR="/backup/backup-rsync"

    readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
    readonly BACKUP_PATH="''${BACKUP_DIR}/''${DATETIME}"
    readonly LATEST_LINK="''${BACKUP_DIR}/latest"

    mkdir -p "''${BACKUP_DIR}"

    # --dry-run
    ${pkgs.rsync}/bin/rsync --verbose --archive \
      "''${SOURCE_DIR}/" \
      --include-from="''${INCLUDES_FROM}" \
      --exclude="*" \
      --link-dest "''${LATEST_LINK}" \
      "''${BACKUP_PATH}"

    rm -rf "''${LATEST_LINK}"
    ln -s "''${BACKUP_PATH}" "''${LATEST_LINK}"

    end=`date +%s`
    runtime=$(((end-start)/60))
    notify-send "Swift backup" "Backup complete. Duration: ''${runtime} minutes"

  '';
in
{
  systemd.user.services.backup-swift = {
    Unit = {
      Description = "Backup service for swift";
      # Make sure the backup.mount systemd service is active before starting the backup
      Requires = [ "backup.mount" ];
    };
    Service = {
      ExecStart = "${script}";
      Type = "oneshot";
    };
  };
}
