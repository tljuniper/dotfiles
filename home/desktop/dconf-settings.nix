# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/freedesktop/tracker/miner/files" = {
      index-recursive-directories = [ "&DOCUMENTS" "&MUSIC" "&PICTURES" "&VIDEOS" ];
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "/home/juniper/.config/background";
      picture-uri-dark = "/home/juniper/.config/background";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us+altgr-intl" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "lv3:ralt_switch" ];
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "default";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      locate-pointer = true;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "default";
      speed = 3.7878787878787845e-2;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "fingers";
      speed = 0.19823788546255505;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/pixels-l.png";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 2;
      workspace-names = [ "Main" "Workspace 2" "Workspace 3" ];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "terminator --maximize";
      name = "Terminator";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control><Alt>g";
      command = "firefox";
      name = "Firefox";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "audio-output-switcher@anduchs" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "tailscale-status@maxgallup.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com" "Always-Show-Titles-In-Overview@gmail.com" ];
      favorite-apps = [ "firefox.desktop" "chromium-browser.desktop" "code.desktop" "terminator.desktop" "org.gnome.Nautilus.desktop" "signal-desktop.desktop" "org.keepassxc.KeePassXC.desktop" "joplin.desktop" "thunderbird.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "42.4";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/always-show-titles-in-overview" = {
      always-show-window-closebuttons = true;
      hide-background = false;
      show-app-icon = true;
      window-active-size-inc = 15;
      window-title-position = "Bottom";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      click-action = "focus-or-previews";
      custom-background-color = false;
      custom-theme-customize-running-dots = true;
      custom-theme-running-dots-border-color = "rgb(255,255,255)";
      custom-theme-running-dots-color = "rgb(255,255,255)";
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 0.9;
      hide-tooltip = true;
      icon-size-fixed = false;
      middle-click-action = "launch";
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
      preview-size-scale = 0.35;
      running-indicator-dominant-color = false;
      running-indicator-style = "DOTS";
      scroll-action = "cycle-windows";
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
      shortcut = [ "<Super>q" ];
      shortcut-text = "<Super>q";
      show-apps-at-top = true;
      show-mounts-only-mounted = true;
      show-trash = false;
      transparency-mode = "FIXED";
      unity-backlit-items = false;
    };

    "org/gnome/shell/keybindings" = {
      screenshot = [ "Print" ];
      screenshot-window = [ "<Alt>Print" ];
      show-screenshot-ui = [ "<Control>Print" ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };

  };
}
