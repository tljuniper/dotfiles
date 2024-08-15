_:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        git_branch = {
          symbol = "🌱 ";
        };
        nix_shell = {
          format = "via [❄️ ](bold blue) ";
        };
        python = {
          # Is installed by default and therefore printed everywhere
          disabled = true;
        };
        # Uses nerd font otherwise
        battery = {
          full_symbol = "• ";
          charging_symbol = "⇡ ";
          discharging_symbol = "⇣ ";
          unknown_symbol = "❓ ";
          empty_symbol = "❗ ";
        };
      };
    };
  };
}
