{ pkgs, ... }:

# cSpell:disable
{
  # Adding this config file makes sure the XDG standard user directories
  # ("Desktop", "Templates", "Videos", ...) customized the way specified in the file
  home.file.".config/user-dirs.dirs".source = ./user-dirs.dirs;
}
# cSpell:enable
