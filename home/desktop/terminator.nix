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
        background_darkness = 0.9;
        background_image = "None";
        background_type = "transparent";
        font = "DejaVu Sans Mono 12";
        show_titlebar = false;
        use_system_font = false;
        scrollback_infinite = true;
      };
      plugins.ActivityWatch = {
        hush_period = 30.0;
      };
    };
  };
}
