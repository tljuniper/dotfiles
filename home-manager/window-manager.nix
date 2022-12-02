{ pkgs, lib, config, ... }:

let
  timeCommand = "libreoffice --calc";
  modifier = config.xsession.windowManager.i3.config.modifier;
  ws1 = "1: web";
  ws2 = "2: code";
  ws3 = "3: ";
  ws4 = "4: ";
  ws5 = "5: ";
  ws6 = "6: ";
  ws7 = "7: meet";
  ws8 = "8: IM";
  ws9 = "9: mail";
  ws0 = "10: timesheet";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      assigns = {
        "${ws1}" = [ {class = "^firefox|Chromium-browser"; }];
        "${ws2}" = [ {class = "Visual Studio Code"; }];
        "${ws0}" = [ {class = "(?)[lL]ibre[oO]ffice.*"; } ];
        "${ws7}" = [ {title = "Besprechung|Meeting"; }];
        "${ws8}" = [ {class = "^Signal|Mattermost$"; } ];
        "${ws9}" = [ {class = "^Thunderbird$";}  ];
      };
      defaultWorkspace = "workspace \"${ws1}\"";
      focus = {
        newWindow = "focus";
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+x" = "move workspace to output next";
        "${modifier}+Tab" = "workspace back_and_forth";
        "${modifier}+q" = "workspace next";
        "${modifier}+Control+q" = "workspace prev";
        "${modifier}+g" = "split horizontal";
        # Workspace names
        "${modifier}+0" = "workspace ${ws0}";
        "${modifier}+1" = "workspace ${ws1}";
        "${modifier}+2" = "workspace ${ws2}";
        "${modifier}+3" = "workspace ${ws3}";
        "${modifier}+4" = "workspace ${ws4}";
        "${modifier}+5" = "workspace ${ws5}";
        "${modifier}+6" = "workspace ${ws6}";
        "${modifier}+7" = "workspace ${ws7}";
        "${modifier}+8" = "workspace ${ws8}";
        "${modifier}+9" = "workspace ${ws9}";
        # Moving
        "${modifier}+Shift+0" = "move container to workspace ${ws0}";
        "${modifier}+Shift+1" = "move container to workspace ${ws1}";
        "${modifier}+Shift+2" = "move container to workspace ${ws2}";
        "${modifier}+Shift+3" = "move container to workspace ${ws3}";
        "${modifier}+Shift+4" = "move container to workspace ${ws4}";
        "${modifier}+Shift+5" = "move container to workspace ${ws5}";
        "${modifier}+Shift+6" = "move container to workspace ${ws6}";
        "${modifier}+Shift+7" = "move container to workspace ${ws7}";
        "${modifier}+Shift+8" = "move container to workspace ${ws8}";
        "${modifier}+Shift+9" = "move container to workspace ${ws9}";
        # Vim-style window navigation
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        # Screenshot
        "Control+Print" = "exec flameshot gui";
        # Open timesheet
        "${modifier}+Control+e" = "exec \"${timeCommand}\"";
      };
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "bottom";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status}/bin/i3status";
          command = "${pkgs.i3-gaps}/bin/i3bar -t";
          fonts = {
            names = ["Nimbus Sans"];
            size = 13.0;
          };
        }
      ];
      startup = [
        { command = "sleep 1; xrandr --output HDMI-1 --primary; xrandr --output eDP-1 --auto --right-of HDMI-1; xrandr --output DP-1 --auto --left-of HDMI-1"; }
        { command = "mattermost-desktop"; }
        { command = "sleep 1; signal-desktop"; }
        { command = "thunderbird"; }
        { command = "${timeCommand}"; }
        { command = "nm-applet"; }
        { command = "chromium"; }
      ];
      workspaceAutoBackAndForth = true;
      workspaceOutputAssign = [
        {
          workspace = "${ws8}";
          output = "eDP-1";
        }
        {
          workspace = "${ws9}";
          output = "HDMI-1";
        }
        {
          workspace = "${ws1}";
          output = "HDMI-1";
        }
        {
          workspace = "${ws7}";
          output = "HDMI-1";
        }
        {
          workspace = "${ws0}";
          output = "DP-1";
        }
      ];
    };
  };
  programs.i3status = {
    enable = true;
    modules = {
      "volume master" = {
        position = 1;
        settings = {
          format = "♪ %volume";
          format_muted = "♪ muted (%volume)";
          device = "pulse:1";
        };
      };
      "wireless _first_" = {
        position = 1;
        settings = {
          format_up = "W: (%quality)";
          format_down = "W: down";
        };
      };
      "ethernet _first_" = {
        position = 2;
        settings = {
          format_up = "E: (%speed)";
          format_down = "E: down";
        };
      };
    };
  };
}
