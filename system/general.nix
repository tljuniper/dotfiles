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

  # Enable the function keys for Keychron keyboard
  # https://mikeshade.com/posts/keychron-linux-function-keys/
  environment.etc."modprobe.d/hid_apple.conf".text =
    ''
      options hid_apple fnmode=0
    '';

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