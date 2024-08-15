{ lib, ... }:
{
  # I found this helpful for formatting:
  # https://qfpl.io/posts/installing-nixos/
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # EFI system partition
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
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraOpenArgs = [ ];
              # if you want to use the key for interactive login be sure there is no trailing newline
              # for example use `echo -n "password" > /tmp/secret.key`
              # Note: this file needs to be present on the target machine, not on the source machine!
              passwordFile = "/tmp/secret.key";
              settings = {
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "16GiB";
            content = {
              type = "swap";
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
