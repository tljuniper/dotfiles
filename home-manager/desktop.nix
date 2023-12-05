{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    aspell
    aspellDicts.de
    baobab
    chromium
    evince
    exiftool
    firefox
    # Manually configure "flameshot gui" command on keystroke CTRL-Print.
    # Use "flameshot config" once to configure default save locations/filenames
    # and other flameshot settings
    flameshot
    gnome.gedit
    gnome.gnome-tweaks
    gnome.gnome-screenshot
    # Gnome extensions. Note: These are now present in "extensions" app where
    # they have to be turned on and configured manually
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tailscale-status
    gnomeExtensions.always-show-titles-in-overview
    google-chrome
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    imagemagick
    inkscape
    joplin-desktop
    keepassxc
    kicad-small
    libreoffice
    libnotify
    # nautilus-open-any-terminal --> doesn't seem to work so far, more research needed
    nextcloud-client
    ocrmypdf
    poppler_utils
    python3
    signal-desktop
    thunderbird
    vlc
    xclip
  ];

  programs.terminator = {
    enable = true;
    config = {
      global_config = {
        enabled_plugins = "LaunchpadBugURLHandler, LaunchpadCodeURLHandler, ActivityWatch";
      };
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
      plugins.ActivityWatch = {
        hush_period = 30.0;
      };
    };
  };
}
