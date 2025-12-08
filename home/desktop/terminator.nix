_:
{
  programs.terminator = {
    enable = true;
    config = {
      global_config = {
        enabled_plugins = "LaunchpadBugURLHandler, LaunchpadCodeURLHandler, ActivityWatch";
      };
      layouts.default.child1 = {
        parent = "window0";
        type = "Terminal";
      };
      layouts.default.window0 = {
        parent = "";
        type = "Window";
      };
      profiles.default = {
        background_darkness = 1;
        background_image = "None";
        background_type = "transparent";
        font = "DejaVu Sans Mono 11";
        show_titlebar = false;
        use_system_font = false;
        scrollback_infinite = true;
        cursor_color = "#f5e0dc";
        background_color = "#1e1e2e";
        foreground_color = "#cdd6f4";
        palette =
          "#45475a:#f38ba8:#a6e3a1:#f9e2af:#89b4fa:#f5c2e7:#94e2d5:#bac2de:#585b70:#f38ba8:#a6e3a1:#f9e2af:#89b4fa:#f5c2e7:#94e2d5:#a6adc8";
      };
      plugins.ActivityWatch = {
        hush_period = 30.0;
      };
    };
  };
}
