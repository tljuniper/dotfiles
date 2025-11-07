{ pkgs, ... }:

{
  imports = [
    ./terminator.nix
    ./vscode.nix
    ./dconf-settings.nix
  ];

  home.packages = with pkgs; [
    aspell
    aspellDicts.de
    baobab
    chromium
    evince
    exiftool
    firefox
    gedit
    gnome-tweaks
    gnome-screenshot
    # Gnome extensions. Note: These are now present in "extensions" app where
    # they have to be turned on and configured manually
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tailscale-status
    gnupg
    google-chrome
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    imagemagick
    inkscape
    keepassxc
    # kicad-small
    libreoffice
    libnotify
    # nautilus-open-any-terminal --> doesn't seem to work so far, more research needed
    nextcloud-client
    ocrmypdf
    openscad
    poppler_utils
    python3
    signal-desktop
    thunderbird
    timewarrior
    vlc
    xclip
    # Fonts
    dejavu_fonts
    ubuntu_font_family
    powerline-fonts
  ];

  fonts.fontconfig.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

}
