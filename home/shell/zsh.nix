_:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion = {
        # Sources pkgs.zsh-autosuggestions (--> zsh-users/zsh-autosuggestions)
        enable = true;
        strategy = [ "history" "completion" ];
      };
      # Add `pkgs.nix-zsh-completions` to home.packages
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        Grep = "grep -Hirn --color=auto";
        l = "ls -h -CFAl --color=auto";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "copybuffer"
          "copyfile"
          "colored-man-pages"
          "fzf"
          "git"
          "sudo"
          "history"
        ];
      };
    };
  };
}
