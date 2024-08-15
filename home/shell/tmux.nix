{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      # Leader/prefix key
      shortcut = "a";
      # $SHELL is bash when in nix-shell, so set to zsh to prevent tmux from using bash
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };

}
