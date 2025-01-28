_:
{
  programs = {
    starship = {
      enable = true;
      settings = {
        # Uses nerd font otherwise
        battery = {
          full_symbol = "• ";
          charging_symbol = "⇡ ";
          discharging_symbol = "⇣ ";
          unknown_symbol = "❓ ";
          empty_symbol = "❗ ";
        };
        character = {
          success_symbol = "[❯](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
        cmd_duration = {
          show_notifications = true;
        };
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
      };
    };
  };
}
