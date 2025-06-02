{ pkgs, inputs, lib, ... }:
{

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "de_DE.UTF-8";
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat # cat but fancy
    curl
    detox # Cleanup filenames with special characters
    diff-so-fancy # Mainly for use with git
    dos2unix
    dool # Resource usage
    fzf # Command line fuzzy finder
    git
    htop
    jq # Json pretty print
    lm_sensors
    pdfgrep
    nix
    rsync
    screen
    tree
    tmux
    unixtools.netstat
    unzip
    usbutils
    vim
    wget
  ];

  # <nixpkgs> is evaluated to what's in the NIX_PATH variable
  # Use separate folder nix/inputs/nixpkgs so changes are easier to apply to already running processes
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;

  nix = {
    nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];

    # Make sure flake registry uses this version of nixpkgs
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # Timeout for connecting to cache
      connect-timeout = 5;
      # Output lines to show for for failed builds
      log-lines = 25;
      # When to start running garbage collection
      min-free = 32000000000; # (32 GB)
      # When to stop running garbage collection
      max-free = 64000000000; # (64 GB)
      # Don't warn when seeing dirty git trees
      warn-dirty = false;
      # Hard link duplicate paths in the store
      auto-optimise-store = true;
      # For development
      keep-outputs = true;
      # Flakes
      experimental-features = [ "nix-command" "flakes" ];
    };

  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
}
