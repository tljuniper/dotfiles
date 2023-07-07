{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems = {
    # USB drive labelled 'backup'
    # The main drive is configured via the SD image installer
    "/backup" = {
      device = "/dev/disk/by-label/backup";
      fsType = "ext4";
    };
  };

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  hardware.enableRedistributableFirmware = true;
}
