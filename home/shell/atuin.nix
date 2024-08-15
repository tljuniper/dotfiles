_:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    # flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      inline_height = 20;
      dotfiles = {
        enabled = false;
      };
    };
  };
}
