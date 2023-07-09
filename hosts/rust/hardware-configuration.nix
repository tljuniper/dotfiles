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

  # https://forums.raspberrypi.com/viewtopic.php?t=245931
  # USB adapter for SSD doesn't work well with uas
  # Disable uas for this device and fall back to normal storage driver
  boot.kernelParams = [ "usb-storage.quirks=174c:225c:u" ];

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  hardware.enableRedistributableFirmware = true;
}
