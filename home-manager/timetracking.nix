{ pkgs, ... }:
{
  systemd.user.services.timetracking-start = {
    Unit = {
      Description = "Run timetracking start on bootup";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
    Service = {
      ExecStart = pkgs.writeScript "start_tracking.sh" ''
        #!/usr/bin/env bash
        set -euxo pipefail

        ${pkgs.timewarrior}/bin/timew start
      '';
      Type = "oneshot";
    };
  };
  systemd.user.services.timetracking-stop = {
    Unit = {
      Description = "Run timetracking stop on shutdown";
    };
    Install = {
      WantedBy = [ "halt.target" "reboot.target" "shutdown.target" "poweroff.target" ];
    };
    Service = {
      ExecStart = pkgs.writeScript "stop_tracking.sh" ''
        #!/usr/bin/env bash
        set -euxo pipefail

        ${pkgs.timewarrior}/bin/timew stop
      '';
      Type = "oneshot";
    };
  };
}
