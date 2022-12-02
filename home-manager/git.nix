{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
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
