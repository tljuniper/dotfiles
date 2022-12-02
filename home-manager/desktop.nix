{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aspell
    aspellDicts.de
    baobab
    chromium
    evince
    firefox
    flameshot
    gnome.cheese
    google-chrome
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    imagemagick
    keepassxc
    libreoffice
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
      };
    };
  };

}
