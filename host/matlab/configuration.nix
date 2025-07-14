# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader =
    {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
    };

  networking = {
    hostName = "matlab"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Required for tailscale
    firewall.checkReversePath = "loose";
  };

  services = {
    tailscale.enable = true;
  };

  # see: https://github.com/NixOS/nixpkgs/issues/416322
  services.xserver.displayManager.gdm.wayland = lib.mkForce false;

  # Try to boot, even if some file systems are missing
  systemd.enableEmergencyMode = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.autoUpgrade = {
    enable = true;
    persistent = true;
    flake = "github:tljuniper/dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
  };

  programs.zsh.enable = true;

  users.users.europa = {
    isNormalUser = true;
    home = "/home/europa";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
    initialPassword = "change-me";
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    baobab
    chromium
    evince
    firefox
    gedit
    gnome-tweaks
    gnupg
    google-chrome
    keepassxc
    libreoffice
    libnotify
    thunderbird
    vlc
    xclip
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
