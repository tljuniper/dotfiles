_:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        Grep = "grep -Hirn --color=auto";
        l = "ls -h -CFAl --color=auto";
      };
      sessionVariables = {
        CONDA_DEFAULT_ENV = "";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "copybuffer"
          "copyfile"
          "colored-man-pages"
          "git"
          "sudo"
          "history"
          "web-search"
        ];
        theme = "af-magic";
      };
    };
  };
}
