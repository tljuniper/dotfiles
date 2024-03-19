{ pkgs, ... }:
{
  systemd.user.services.run-rotation = {
    Unit = {
      Description = "Run rotation service";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
    Service = {
      ExecStart = pkgs.writeScript "rotate.sh" ''
        #!/usr/bin/env bash
        set -euo pipefail

        ~/rotate.sh -f
      '';
      Type = "oneshot";
    };
  };
  systemd.user.timers.run-rotation = {
    Unit = {
      Description = "Daily rotation timer";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
    Timer = {
      OnBootSec = "5m";
      OnUnitInactiveSec = "1d";
    };
  };
}
