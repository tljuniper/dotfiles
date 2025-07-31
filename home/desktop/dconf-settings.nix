# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "apps/seahorse/listing" = {
      keyrings-selected = [ "gnupg://" ];
    };

    "apps/seahorse/windows/key-manager" = {
      height = 1021;
      width = 1908;
    };

    "org/freedesktop/tracker/miner/files" = {
      index-recursive-directories = [ "&DOCUMENTS" "&MUSIC" "&PICTURES" "&VIDEOS" ];
    };

    "org/gnome/Console" = {
      last-window-maximised = true;
      last-window-size = mkTuple [ 652 480 ];
    };

    "org/gnome/Loupe" = {
      show-properties = true;
    };

    "org/gnome/Snapshot" = {
      is-maximized = false;
      last-camera-id = "HD Pro Webcam C920 (V4L2)";
      window-height = 640;
      window-width = 800;
    };

    "org/gnome/Weather" = {
      window-height = 496;
      window-maximized = false;
      window-width = 992;
    };

    "org/gnome/baobab/ui" = {
      active-chart = "rings";
      is-maximized = true;
      window-size = mkTuple [ 960 600 ];
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "basic";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "";
      source-units = "degree";
      target-currency = "";
      target-units = "radian";
      window-maximized = false;
      window-size = mkTuple [ 360 666 ];
      word-size = 64;
    };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "world";
      size = mkTuple [ 870 690 ];
    };

    "org/gnome/control-center" = {
      last-panel = "background";
      window-state = mkTuple [ 980 640 false ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "/home/juniper/.config/background";
      picture-uri-dark = "/home/juniper/.config/background";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/break-reminders" = {
      selected-breaks = [];
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = mkUint32 300;
      interval-seconds = mkUint32 1800;
      play-sound = true;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us+altgr-intl" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "lv3:ralt_switch" ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "purple";
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-size = 24;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      locate-pointer = true;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-power-panel" "code" "signal-desktop" "thunderbird" "gnome-network-panel" "firefox" "org-gnome-evince" "com-nextcloud-desktopclient-nextcloud" "org-gnome-fileroller" "chromium-browser" "org-gnome-nautilus" "org-gnome-extensions-desktop" "gnome-printers-panel" "org-gnome-settings" "org-inkscape-inkscape" "org-gnome-loupe" "org-gnome-extensions" "bambustudio" "signal" ];
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/notifications/application/bambustudio" = {
      application-id = "BambuStudio.desktop";
    };

    "org/gnome/desktop/notifications/application/chromium-browser" = {
      application-id = "chromium-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/code" = {
      application-id = "code.desktop";
    };

    "org/gnome/desktop/notifications/application/com-nextcloud-desktopclient-nextcloud" = {
      application-id = "com.nextcloud.desktopclient.nextcloud.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-printers-panel" = {
      application-id = "gnome-printers-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-wellbeing-panel" = {
      application-id = "gnome-wellbeing-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/impress" = {
      application-id = "impress.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      application-id = "org.gnome.Evince.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-extensions-desktop" = {
      application-id = "org.gnome.Extensions.desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-extensions" = {
      application-id = "org.gnome.Extensions.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-gedit" = {
      application-id = "org.gnome.gedit.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-loupe" = {
      application-id = "org.gnome.Loupe.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-inkscape-inkscape" = {
      application-id = "org.inkscape.Inkscape.desktop";
    };

    "org/gnome/desktop/notifications/application/signal-desktop" = {
      application-id = "signal-desktop.desktop";
    };

    "org/gnome/desktop/notifications/application/signal" = {
      application-id = "signal.desktop";
    };

    "org/gnome/desktop/notifications/application/terminator" = {
      application-id = "terminator.desktop";
    };

    "org/gnome/desktop/notifications/application/thunderbird" = {
      application-id = "thunderbird.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "default";
      natural-scroll = false;
      speed = 3.7879e-2;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "fingers";
      speed = 0.198238;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/pixels-l.png";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.seahorse.Application.desktop" "org.gnome.Contacts.desktop" "org.gnome.clocks.desktop" ];
      sort-order = [ "org.gnome.Settings.desktop" "org.gnome.Documents.desktop" "org.gnome.Contacts.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" "org.gnome.clocks.desktop" "org.gnome.seahorse.Application.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 900;
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      unmaximize = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      action-middle-click-titlebar = "minimize";
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 2;
      workspace-names = [ "Main" "Workspace 2" "Workspace 3" ];
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = false;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "free";
      window-ratio = mkTuple [ 1.473154 1.244656 ];
      zoom = 0.214895;
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/dialogs/extract" = {
      height = 800;
      recreate-folders = true;
      skip-newer = false;
      width = 1000;
    };

    "org/gnome/file-roller/file-selector" = {
      show-hidden = false;
      sidebar-size = 300;
      sort-method = "name";
      sort-type = "ascending";
      window-size = mkTuple [ (-1) (-1) ];
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 166;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/gedit/state/window" = {
      bottom-panel-size = 140;
      height = 700;
      maximized = true;
      side-panel-active-page = "GeditWindowDocumentsPanel";
      side-panel-size = 200;
      size = mkTuple [ 1840 1001 ];
      state = 43780;
      width = 900;
    };

    "org/gnome/gnome-screenshot" = {
      delay = 0;
      include-pointer = false;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "processes";
      maximized = true;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-state = mkTuple [ 2476 1408 0 0 ];
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      col-0-visible = true;
      col-0-width = 489;
      col-26-visible = false;
      col-26-width = 0;
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      overlay-key = "Super_L";
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/nautilus/compression" = {
      default-compression-format = "zip";
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "extra-large";
    };

    "org/gnome/nautilus/list-view" = {
      default-column-order = [ "name" "size" "type" "owner" "group" "permissions" "where" "date_modified" "date_modified_with_time" "date_accessed" "date_created" "recency" "detailed_type" ];
      default-visible-columns = [ "name" "size" "date_modified" "detailed_type" ];
      default-zoom-level = "large";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      fts-enabled = false;
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 1668 692 ];
      initial-size-file-chooser = mkTuple [ 890 550 ];
      maximized = false;
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

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Control><Alt>m";
      command = "thunderbird";
      name = "thunderbird";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "suspend";
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 3600;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "audio-output-switcher@anduchs" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "tailscale-status@maxgallup.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com" "Always-Show-Titles-In-Overview@gmail.com" "tilingshell@ferrarodomenico.com" ];
      favorite-apps = [ "firefox.desktop" "chromium-browser.desktop" "code.desktop" "terminator.desktop" "org.gnome.Nautilus.desktop" "signal.desktop" "org.keepassxc.KeePassXC.desktop" "thunderbird.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "42.4";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      animation-time = 0.2;
      autohide = true;
      autohide-in-fullscreen = false;
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
      hide-delay = 0.2;
      hide-tooltip = true;
      icon-size-fixed = false;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      middle-click-action = "launch";
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
      pressure-threshold = 100.0;
      preview-size-scale = 0.35;
      require-pressure-to-show = true;
      running-indicator-dominant-color = false;
      running-indicator-style = "DOTS";
      scroll-action = "cycle-windows";
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
      shortcut = [ "<Super>q" ];
      shortcut-text = "<Super>q";
      show-apps-at-top = true;
      show-delay = 0.25;
      show-dock-urgent-notify = true;
      show-mounts-only-mounted = true;
      show-trash = false;
      transparency-mode = "FIXED";
      unity-backlit-items = false;
    };

    "org/gnome/shell/extensions/tiling-assistant" = {
      focus-hint-color = "rgb(145,65,172)";
      last-version-installed = 52;
    };

    "org/gnome/shell/extensions/tilingshell" = {
      enable-autotiling = true;
      enable-blur-snap-assistant = true;
      enable-smart-window-border-radius = false;
      enable-window-border = true;
      focus-window-down = [ "<Shift><Control>j" ];
      focus-window-left = [ "<Shift><Control>h" ];
      focus-window-right = [ "<Shift><Control>l" ];
      focus-window-up = [ "<Shift><Control>k" ];
      inner-gaps = mkUint32 3;
      last-version-name-installed = "16.4";
      layouts-json = "[{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]},{\"id\":\"19427867\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.5,\"height\":0.5,\"groups\":[1,3]},{\"x\":0.5,\"y\":0,\"width\":0.5000000000000002,\"height\":0.5,\"groups\":[2,1]},{\"x\":0.5,\"y\":0.5,\"width\":0.5000000000000002,\"height\":0.5000000000000002,\"groups\":[2,1]},{\"x\":0,\"y\":0.5,\"width\":0.5,\"height\":0.49999999999999933,\"groups\":[3,1]}]},{\"id\":\"19498345\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.5,\"height\":1,\"groups\":[1]},{\"x\":0.5,\"y\":0,\"width\":0.4999999999999998,\"height\":1,\"groups\":[1]}]}]";
      outer-gaps = mkUint32 3;
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      quarter-tiling-threshold = mkUint32 25;
      selected-layouts = [ [ "Layout 4" ] [ "Layout 4" ] ];
      top-edge-maximize = true;
      window-border-color = "rgb(192,97,203)";
    };

    "org/gnome/shell/keybindings" = {
      screenshot = [ "Print" ];
      screenshot-window = [ "<Alt>Print" ];
      show-screenshot-ui = [ "<Control>Print" ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 0.5768749713897705 0.3683333396911621 0.7366666793823242 1.0 ]) (mkTuple [ 2.7450986206531525e-2 0.30980393290519714 0.13725489377975464 1.0 ]) (mkTuple [ 0.9254902005195618 0.3686274588108063 0.3686274588108063 1.0 ]) ];
      selected-color = mkTuple [ true 0.7529411911964417 0.3803921639919281 0.7960784435272217 1.0 ];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 975 630 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 167;
      sort-column = "modified";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 399 82 ];
      window-size = mkTuple [ 1203 902 ];
    };

  };
}
