{ config, pkgs, lib, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
 
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
    
  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  services.openssh.enable = true;

  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "22.05";

  networking.hostName = "rust";

}
