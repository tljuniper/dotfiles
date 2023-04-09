{ pkgs, ... }:
let
  start_backup = pkgs.writeScript "start_backup.sh" ''
    #!/usr/bin/env bash
    set -euox pipefail
    ${pkgs.systemd}/bin/systemctl start backup.mount
    ${pkgs.systemd}/bin/systemctl --machine juniper@.host --user start backup-swift.service
  '';
in
{
  # Add additional UDEV rule to launch backup whenever hard drive is connected
  # Find PRODUCT string for your harddrive by keeping udevadm running and connecting the drive:
  # udevadm monitor --environment --udev | grep PRODUCT
  # --> replace in udev rule
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="480/a006/107", RUN+="${start_backup}"
  '';
}
