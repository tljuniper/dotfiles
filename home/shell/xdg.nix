{ config, lib, ... }:
{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = lib.mkDefault true;

      download = config.home.homeDirectory + "/Downloads";
      pictures = config.home.homeDirectory + "/Pictures";
      music = config.home.homeDirectory + "/Music";

      desktop = config.home.homeDirectory;
      documents = config.home.homeDirectory;
      publicShare = config.home.homeDirectory;
      templates = config.home.homeDirectory;
      videos = config.home.homeDirectory;

      # extraConfig = {
      #   XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/pictures/screenshots";
      # };
    };
  };
}
