{ config, lib, pkgs, modulesPath, ... }:
{

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };

    "/backup" = {
      device = "/dev/disk/by-label/backup";
      fsType = "ext4";
    };
  };

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  hardware.enableRedistributableFirmware = true;

}
