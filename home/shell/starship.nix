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
          min_time = 5000;
          min_time_to_notify = 120000;
          show_notifications = true;
          notification_timeout = 5000;
        };
        direnv = {
          disabled = false;
          symbol = "";
          format = "[$symbol$loaded]($style)";
          not_allowed_msg = "direnv not allowed";
          unloaded_msg = "direnv not loaded";
          denied_msg = "direnv denied";
          allowed_msg = "";
          loaded_msg = "";
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
