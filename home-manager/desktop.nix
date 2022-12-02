{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
    evince
    firefox
    imagemagick
    keepassxc
    signal-desktop
    thunderbird
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
