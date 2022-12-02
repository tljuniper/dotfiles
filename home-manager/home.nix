{ config, pkgs, ... }:

let
  # System-dependent values
  username = "";
  # Used for git
  fullName = "";
  email = "";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ------------------------------------------------------------------

  home.packages = [
    pkgs.htop
    pkgs.diff-so-fancy
    pkgs.jq
    pkgs.tree
    pkgs.bat
    pkgs.fzf
  ];

  home.file.".aspell.de_DE.prepl".source = ./aspell.de_DE.prepl;
  home.file.".aspell.de_DE.pws".source = ./aspell.de_DE.pws;
  home.file.".aspell.en.prepl".source = ./aspell.en.prepl;
  home.file.".aspell.en.pws".source = ./aspell.en.pws;

  home.file.".config/terminator/config".source = ./terminator_config;

  programs.autojump = {
    enable = true;
  };

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

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # programs.vscode = {
  #   enable = true;
  #   extensions = [
  #     pkgs.vscode-extensions.shardulm94.trailing-spaces
  #   ];
  # };

}
