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
      initContent = ''
        setopt menu_complete
        setopt always_to_end
      '';
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
          "web-search"
        ];
      };
    };
  };
}
