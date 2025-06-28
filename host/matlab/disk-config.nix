{ lib, ... }:
{
  # I found this helpful for formatting:
  # https://qfpl.io/posts/installing-nixos/
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/disk/by-id/ata-SD_Ultra_3D_500GB_25112D800094";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            start = "1MiB";
            end = "1GiB";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            end = "-1G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          swap = {
            size = "100%";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
        };
      };
    };
  };
}
