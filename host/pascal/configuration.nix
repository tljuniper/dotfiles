# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "pascal"; # Define your hostname.

    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Required for tailscale
    firewall.checkReversePath = "loose";
  };

  services = {
    tailscale.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Store journald config in RAM to help preserve the sd card
    journald.storage = "volatile";
  };

  nix.settings.trusted-users = [ "@wheel" ];
  security.sudo.wheelNeedsPassword = false;

  # This makes the build be a .img instead of a .img.zst
  sdImage.compressImage = false;

  # This Pi is slow and starting up home manager might take longer
  systemd.services.home-manager-juniper.serviceConfig.TimeoutStartSec = lib.mkForce 120;

  # Small-ish SD-card
  nix.settings.min-free = lib.mkForce 4000000000; # (4 GB)

  # Try to boot, even if some file systems are missing
  systemd.enableEmergencyMode = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
