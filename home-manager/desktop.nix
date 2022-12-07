{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    aspell
    aspellDicts.de
    baobab
    chromium
    evince
    firefox
    gnome.cheese
    gnome.gedit
    gnome.gnome-tweaks
    gnome.gnome-screenshot
    # Gnome extensions. Note: These are now present in "extensions" app where
    # they have to be turned on and configured manually
    gnomeExtensions.dash-to-dock
    gnomeExtensions.sound-output-device-chooser
    google-chrome
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    imagemagick
    keepassxc
    libreoffice
    libnotify
    nextcloud-client
    python3
    signal-desktop
    thunderbird
    vlc
  ];

  programs.terminator = {
    enable = true;
    config = {
      layouts.default.child1 = {
        parent = "window0";
        type = "Terminal";
      };
      layouts.default.window0 = {
        parent = "";
        type = "Window";
      };
      profiles.default = {
        background_darkness = 0.9;
        background_image = "None";
        background_type = "transparent";
        font = "DejaVu Sans Mono 12";
        show_titlebar = false;
        use_system_font = false;
        scrollback_infinite = true;
      };
    };
  };

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username_cmd = "cat ~/.spotify/username";
        password_cmd = "cat ~/.spotify/password";
        device_name = "swift";
      };
    };
  };
}
