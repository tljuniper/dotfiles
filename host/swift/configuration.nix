# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader =
    {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
    };

  networking = {
    hostName = "swift"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Required for tailscale
    firewall.checkReversePath = "loose";
  };

  services = {
    tailscale.enable = true;
  };

  # No ssh daemon on this machine, so we need some way to login after an automated install
  # Don't move this to the user-juniper.nix file, we don't want this setting for other machines
  users.users.juniper.initialPassword = "change-me";

  system.autoUpgrade = {
    enable = true;
    persistent = true;
    flake = "${config.users.users.juniper.home}/dotfiles";
    flags = [
      "update"
      "nixpkgs"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
