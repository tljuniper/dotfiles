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

}
