{ config, pkgs, ... }:

let
  # System-dependent values
  username = "";
  # Used for git
  fullName = "";
  email = "";
in
{
  programs.git = {
    enable = true;
    userName = fullName;
    userEmail = email;
    aliases = {
      lol = "log --oneline";
      rofl = "log --oneline";
      unstage = "restore --staged";
    };
    extraConfig = {
      pager = {
        branch = false;
      };
      core = {
        editor = "vim";
      };
      interactive.diffFilter = "${pkgs.diff-so-fancy}/bin/diff-so-fancy --patch";
    };
  };
}
