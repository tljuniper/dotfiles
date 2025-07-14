{ pkgs, ... }:
{
  imports = [
    ./atuin.nix
    ./direnv.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix
    ./zsh.nix
  ];

  programs = {
    autojump.enable = true;
    git.enable = true;
    home-manager.enable = true;
    jq.enable = true;
  };
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    age
    sops
  ];
}
