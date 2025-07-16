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
    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      # Widget to change directory with fzf with ALT-C keybinding
      changeDirWidgetOptions = [
        "--preview 'tree -C {} | head -100'"
      ];
      # Widget to select a file (and copy the path to the command line) with
      # CTRL-T
      fileWidgetOptions = [
      ];
      defaultOptions = [
        "--style full"
        "--walker-skip .git,.direnv,result"
        "--preview 'bat -n --color=always {}'"
        "--border --padding 1,2"
        "--border-label ' fzf ' --input-label ' Input ' --header-label ' File Type '"
        "--bind 'focus:transform-preview-label:[[ -n {} ]] && printf \\\" Previewing [%s] \\\" {}' "
        "--bind 'focus:+transform-header:file --brief {} || echo \\\"No file # selected\\\"' "
        "--bind='ctrl-d:abort'"
      ];
    };
  };
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    age
    sops
  ];
}
