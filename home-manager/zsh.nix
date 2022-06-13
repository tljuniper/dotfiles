{ pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
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
        "dirhistory"
        "git"
        "history"
        "web-search"
      ];
      theme = "af-magic";
    };
  };
}
