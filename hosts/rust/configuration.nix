# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "rust"; # Define your hostname.

    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Required for tailscale
    firewall.checkReversePath = "loose";
  };

  services.tailscale.enable = true;

  nix.settings.trusted-users = [ "@wheel" ];
  security.sudo.wheelNeedsPassword = false;

  # This makes the build be a .img instead of a .img.zst
  sdImage.compressImage = false;

  # Try to boot, even if some file systems are missing
  systemd.enableEmergencyMode = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
