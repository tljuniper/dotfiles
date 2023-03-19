{ config, lib, pkgs, ... }:
{

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "de_DE.UTF-8";
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
    diff-so-fancy # Mainly for use with git
    dos2unix
    dstat # Resource usage
    fzf # Command line fuzzy finder
    git
    htop
    jq # Json pretty print
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


  nix.settings = {
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

}
